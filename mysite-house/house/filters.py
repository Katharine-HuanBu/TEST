import django_filters
from .models import *

#RentFilter
class RentFilter(django_filters.FilterSet):
    """
    Rent
    """
    #Create a date filter
    create_at = django_filters.filters.DateFromToRangeFilter()
    class Meta:
        model = Rent
        #The character set is the time of creation
        fields = ['create_at']
        #The query set displays the house information that meets the criteria
        @property
        def qs(self):
            parent = super().qs
            return parent

#Stall filter
class HouseFilter(django_filters.FilterSet):
    """
    House filter
    """
    #Use the state of the house as a filter
    status = django_filters.ChoiceFilter(choices=House.STATUS_CHOICES)

    class Meta:
        model = House
        #The fields are no longer a list, but a dictionary. The keys are the names of the fields in the model. The values are a list of the operations that can be performed
        fields = {
            'name': ['contains'],
            'position': ['contains', ],
            'area': ['lt', 'gt'],
            'price': ['lt', 'gt'],


        }

        @property
        def qs(self):
            parent = super().qs
            return parent
