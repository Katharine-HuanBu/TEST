from django_tables2 import tables
from django_tables2.utils import A
from .models import *
from django.utils.html import format_html


class ImageColumn(tables.columns.Column):
    """
    Custom pictures
    """
    def render(self, value):
        return format_html(
            '<img src="/media/{url}" style="width:200px" class="img-responsive img-thumbnail center-block"> ',
            url=value
            )

class StatusColumn(tables.columns.Column):
    def render(self, value):
        status = value
        color_map = {
            'wait to rent': 'color: green',
            'rented': 'color: red'
        }
        return format_html(
            '<span style="{}" >{}</span>'.format(color_map[status], status)
        )

class DeadlineColumn(tables.columns.Column):
    """

    """
    def render(self, value):
        status = value
        color_map = {
            'wait to rent': 'color: green',
        }
        if value in color_map:
            color = color_map[status]
        else:
            color = 'color: red'
        print(status)
        return format_html(
            '<span style="{}" >{}</span>'.format(color, status)
        )

class HouseTable(tables.Table):
    """
    定义Modeltable
    https://django-tables2.readthedocs.io/en/latest/pages/table-data.html#table-data
    """

    # Customize column
    picture = ImageColumn()
    status = StatusColumn()
    deadline = DeadlineColumn(orderable=False)
    detail = tables.columns.LinkColumn('detail', args=[A('pk')], orderable=False, empty_values=(), verbose_name='Action')
    def render_detail(self):
        return 'Detail'

    class Meta:
        # Specify the model
        model = House
        # Customize properties
        attrs = {"class": "table table-striped"}
        exclude = ('update_time', )
        # define template
        template_name = 'django_tables2/bootstrap.html'