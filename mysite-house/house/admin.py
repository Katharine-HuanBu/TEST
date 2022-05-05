from django.contrib import admin
from django.db import transaction
from .views import tongji
from .models import *

admin.site.site_header = 'Farm House Booking System'
admin.site.site_title = 'Farm House Booking System'


# Register your models here.

@admin.register(House)
class HouseAdmin(admin.ModelAdmin):
    # Search box at the top of the list page
    search_fields = ('name',)
    # Filter bar on the right side of the list page
    list_filter = ('status',)
    # The column name that the list displays
    list_display = ('name', 'description', 'area', 'position', 'price', 'create_at', 'status')


@admin.register(Rent)
class RentAdmin(admin.ModelAdmin):
    # Filter bar on the right side of the list page
    list_filter = ('status',)
    # The column name that the list displays
    list_display = ('house', 'user', 'create_at', 'deadline', 'months', 'status', 'money')


@transaction.atomic
def approve_unsubscribe(modeladmin, request, queryset):
    """
    approve_unsubscribe
    :param modeladmin:
    :param request:
    :param queryset:
    :return:
    """
    qs = queryset.filter(status='wait to approve')

    for q in qs:
        print(q)
        q.rent.house.status = 'wait to rent'
        q.rent.house.save()
        q.rent.status = 'unsubscribed'
        q.rent.save()
    qs.update(status='approve')
    message = 'ok'
    modeladmin.message_user(request, message)


approve_unsubscribe.short_description = 'approve'


@admin.register(Unsubscribe)
class UnsubscribeAdmin(admin.ModelAdmin):
    """
    UnsubscribeAdmin
    """
    actions = [approve_unsubscribe, ]
    list_filter = ('status',)
    list_display = ('rent', 'create_at', 'status', 'update_time', 'is_from_delay')


@admin.register(Delay)
class DelayAdmin(admin.ModelAdmin):
    """
    Delay
    """
    list_display = ('rent', 'create_at', 'deadline', 'months', 'money')

@admin.register(Tongji)
class Tadmin(admin.ModelAdmin):
    def changelist_view(self, request, extra_content=None):
        return tongji(request)