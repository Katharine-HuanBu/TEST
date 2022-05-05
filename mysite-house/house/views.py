import datetime

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db import transaction
from django.shortcuts import render, get_object_or_404, redirect, HttpResponse
from .models import *
from .filters import *
from .tables import *
import json
from django.db.models import Sum

class DateEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.strftime("%Y-%m-%d %H:%M:%S")
        else:
            return json.JSONEncoder.default(self, obj)

# Create your views here.
def index(request):
    """
    mainpage
    :param request:
    :return:
    """
    latest = House.objects.all()[:4]
    return render(request, 'house/index.html', {'latest': latest})


def detail(request, bid):
    """
    detail
    :param request:
    :return:
    """
    house = get_object_or_404(House, id=bid)
    return render(request, 'house/detail.html', {'house': house})

#The search function
def search(request):
    """
    retrieve
    :param request:
    :return:
    """
    # TODO PAGE
    
    #Define search filters
    f = HouseFilter(request.GET, queryset=House.objects.all())
    #Data table is a JS jump list display
    table_data = json.dumps(list(f.qs.values()), cls=DateEncoder)
    #Rendering to return to the search page
    return render(request, 'house/search.html', {'filter': f, 'table_data': table_data})
#New Search Functions
def new_search(request):
    #Sort houses
    sort = request.GET.get('sort', '-1')
    #Specify how to sort
    if sort == '-1':
        qs = House.objects.all()
    else:
        qs = House.objects.all().order_by(sort)
    #Filter to select eligible stalls
    f = HouseFilter(request.GET, queryset=qs)
    #Displays the retrieved data
    qs = f.qs
    #Present data in tabular form
    table = HouseTable(qs)
    #Back to the search page
    return render(request, 'house/new_search.html', {'filter': f, 'table': table})




@transaction.atomic
@login_required
def rent(request):
    """
    Rent
    :param request:
    :param bid:
    :return:
    """
    #Get the number of the rented house
    bid = request.POST.get('bid')
    #Error handling, return 404 when no data is available
    house = get_object_or_404(House, id=bid)
    #Lets say this house has been rented out when its status bit is' rented '
    if house.status == 'rented':
        messages.error(request, 'already rented')
        #Back to main page
        return redirect('/')
    #The status of the assignment house is' rented '
    house.status = 'rented'
    #Save the current state of the house
    house.save()
    #Defining the current leased house, the user is the user who rents a house
    rent = Rent(house=house, user=request.user)
    #Deadline for obtaining house rental
    rent.deadline = request.POST.get('deadline')
    #Obtain the rental period of the house
    rent.months = int(request.POST.get('months'))
    #Calculate the rent of the house
    rent.money = rent.months * rent.house.price
    #Save the attributes of the house
    rent.save()
    #Indicates that the user has rented successfully
    messages.success(request, 'You have rented it !')
    #Back to main page
    return redirect('/')


@transaction.atomic
@login_required
def unsubscribe(request, rid):
    """
    unsubscribe
    :param request:
    :return:
    """
    rent = get_object_or_404(Rent, id=rid)
    if rent.deadline < datetime.datetime.now().date():
        messages.error(request, 'your rent is out of time!')
        redirect('/account/center')
    else:
        rent.status = 'apply to unsubscribe'
        rent.save()
        unsub = Unsubscribe(rent=rent)
        _from = request.GET.get('from', '-1')
        if _from == 'delay':
            unsub.is_from_delay = True
        unsub.status = 'wait to approve'
        unsub.save()
        messages.success(request, 'action ok!')
        return redirect('/account/center')


@transaction.atomic
@login_required
def cancel_ubsub(request, cid):
    # TODO Logic from delay to unsubscribe
    """
    delay->unsubscribe


    :param request:
    :param cid:
    :return:
    """
    ubsub = get_object_or_404(Unsubscribe, id=cid)

    if ubsub.is_from_delay: # From Renewal
        ubsub.rent.status = 'delayed'
    else:
        ubsub.rent.status = 'normal'

    ubsub.rent.save()
    ubsub.delete()
    messages.success(request, 'cancel ok!')
    return redirect('/account/center/')


@transaction.atomic
@login_required
def delay(request, rid):
    """
    delay
        rent: normal You can do that in state
    :param request:
    :param rid:
    :return:
    """
    rent = get_object_or_404(Rent, id=rid)
    if rent.status != 'normal':
        messages.error(request, f'this rent info is {rent.status}, can not delay!')
        return redirect('/account/center/')
    if request.method == 'GET':
        return render(request, 'house/delay.html', {'rent': rent, 'house': rent.house})
    elif request.method == 'POST':
        d = Delay(rent=rent)
        deadline = request.POST.get('deadline')
        months = request.POST.get('months')
        # rent Information update
        rent.status = 'delayed'
        rent.deadline = deadline
        rent.months = months
        rent.money = int(rent.months) * rent.house.price
        rent.save()
        # # house Information update
        # house = rent.house
        # house.deadline = deadline
        # house.save()
        # delay Information update
        d.deadline = deadline
        d.save()
        messages.success(request, 'delay ok!')
        return redirect('/account/center/')

def tongji(request):
    """
    statistical
The contract
● Number of contracts awaiting review
● Number of contracts due

The house
● Total number of houses
● Number of empty houses
● Number of leased houses

profit
● this month the total income of the rent (the rent of each month income can be expressed in a broken line statistical chart, this is all right, see the master design how to do it)
● The rent of the current year's income
    """
    now = datetime.datetime.now()
    contacts = {
        'wait_to_approve': Unsubscribe.objects.filter(status='wait to approve', create_at__month=now.month).count(),
        'deadline': Rent.objects.filter(deadline__lt=now.date()).count(),
        'delay': Rent.objects.filter(status='delayed').count(),
    }
    
    houses = {
        'total': House.objects.all().count(),
        'empty': House.objects.filter(status='wait to rent').count(),
        'used': House.objects.filter(status='rented').count(),
    }

    
    month_money = Rent.objects.filter(create_at__month=now.month).exclude(status='unsubscribed').aggregate(Sum('money'))['money__sum']
    if month_money is None:
        month_money = 0

    year_money = Rent.objects.filter(create_at__year=now.year).exclude(status='unsubscribed').aggregate(Sum('money'))['money__sum']
    if year_money is None:
        year_money = 0
    
    delay_money = Delay.objects.filter(create_at__year=now.year, rent__status='delayed').aggregate(Sum('money'))['money__sum']
    if delay_money is None:
        delay_money = 0

    profits = {
        'month': month_money,
        'year': year_money + delay_money
    }

    return render(request, 'house/tongji2.html', {'contacts':contacts, 'houses': houses, 'profits': profits})

def profit_search(request):
    """
    profit_search
    """
    qs = Rent.objects.exclude(status='unsubscribed')
    start = request.GET.get('start', '').strip()
    end = request.GET.get('end', '').strip()
    if start != '':
        start = datetime.datetime.strptime(start, '%m/%d/%Y')
        qs = qs.filter(create_at__gt=start)
    if end != '':
        end = datetime.datetime.strptime(end, '%m/%d/%Y')
        qs = qs.filter(create_at__lt=end)
    total_profit = qs.aggregate(Sum('money'))['money__sum']
    if total_profit is None:
        total_profit = 0
    return render(request, 'house/profit_search.html', {'qs': qs, 'p': total_profit})
