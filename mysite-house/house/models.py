import datetime
from django.contrib.auth.models import User
from django.db import models


# Create your models here.
class House(models.Model):
    """
    House table
    """
    #Define the field for the name of the house
    name = models.CharField(max_length=32, verbose_name='name')
    # ImageField: Inherit from FileField to validate the uploaded content to make sure it is a valid image
    # Upload the image
    #Define the picture of the house in this field
    picture = models.ImageField(upload_to='houses')
    #Define the description of the house in this field
    description = models.TextField(verbose_name='detail')
    # Define the area of the house in this field
    area = models.FloatField(verbose_name='area')
    # Define the price of the house in this field
    price = models.FloatField(verbose_name='price(permonth)')
    # Define the position of the house in this field
    position = models.CharField(max_length=64, verbose_name='position')
    # Define the create time of the house in this field
    create_at = models.DateTimeField(auto_now_add=True, verbose_name='online time')

    # The current status of house information
    # TODO status Not rent | have for rent
    STATUS_CHOICES = (
        ('wait to rent', 'wait to rent'),
        ('rented', 'rented'),
    )

    status = models.CharField(max_length=32, verbose_name='status', choices=STATUS_CHOICES, default='wait to rent')
    # update time
    update_time = models.DateTimeField(verbose_name='update time', auto_now=True)

    @property
    def deadline(self):
        """
        Display expiration time
        """
        # Find the current rent
        if self.status == 'rented':
            # Find the most recent rental
            lastest_rent = self.rent_set.last()
            status = lastest_rent.status
            if status in ['normal', 'delayed', 'apply to unsubscribe']:
                return lastest_rent.deadline
            else:
                return 'wait to rent'
        else:
            return 'wait to rent'

    class Meta:
        verbose_name = 'house'
        verbose_name_plural = verbose_name
        ordering = ('-create_at',)

    def __str__(self):
        return str(self.name)


class Rent(models.Model):
    """
    Rent
    """
    house = models.ForeignKey(House, on_delete=models.CASCADE, verbose_name='House')
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='User', related_name="h_rent_user")
    create_at = models.DateTimeField(auto_now_add=True, verbose_name='rent time')
    # Lease duration
    months = models.IntegerField(verbose_name='rent_months', default=1)
    # Expiry Time
    deadline = models.DateField(verbose_name='deadline')
    money = models.FloatField(verbose_name='total money', default=0)
    STATUS_CHOICES = (
        ('normal', 'normal'),
        ('apply to unsubscribe', 'apply to unsubscribe'),
        ('unsubscribed', 'unsubscribed'),
        ('delayed', 'delayed'),
    )
    # Unsubscribe needs to be reviewed by the administrator
    status = models.CharField(max_length=32, verbose_name='status', choices=STATUS_CHOICES, default='normal')

    @property
    def total_money(self):
        """
        Total price
        """
        return self.months * self.house.price

    @property
    def is_deadline(self):
        """
        Whether or not on the deadline
        :return:
        """
        return datetime.datetime.now().date() >= self.deadline

    @property
    def current_status(self):
        """
        Current state
        1. The lease
        2. Lease cancellation has been applied for
        3. Succeeded
        4. Continue to postpone
        :return:
        """
        pass
        # TODO

    class Meta:
        verbose_name = 'rent'
        verbose_name_plural = verbose_name
        ordering = ('-create_at',)

    def __str__(self):
        return f'{self.house.name} - {self.user.username} - {self.create_at}'


class Unsubscribe(models.Model):
    """
    Unsubscribe information form
    """
    rent = models.OneToOneField(Rent, on_delete=models.CASCADE, verbose_name='rent info')
    create_at = models.DateTimeField(auto_now_add=True, verbose_name='rent time')
    STATUS_CHOICES = (
        ('wait to approve', 'wait to approve'),
        ('approve', 'approve'),
    )
    # Unsubscribe needs to be reviewed by the administrator
    status = models.CharField(max_length=32, verbose_name='status', choices=STATUS_CHOICES)
    # update time
    update_time = models.DateTimeField(verbose_name='update time', auto_now=True)
    # Whether to come from the delay
    is_from_delay = models.BooleanField(verbose_name='is from delay', default=False)
    class Meta:
        verbose_name = 'subscribe'
        verbose_name_plural = verbose_name
        ordering = ('-create_at',)

    def __str__(self):
        return str(self.rent)


class Delay(models.Model):
    """
    Delay
    """
    rent = models.ForeignKey(Rent, on_delete=models.CASCADE, verbose_name='rent info')
    create_at = models.DateTimeField(auto_now_add=True, verbose_name='create time')
    # Lease duration
    months = models.IntegerField(verbose_name='rent_months', default=1)
    # Extension Time
    deadline = models.DateField(verbose_name='deadline')
    money = models.FloatField(verbose_name='total money', default=0)
    class Meta:
        verbose_name = 'delay'
        verbose_name_plural = verbose_name
        ordering = ('-create_at',)

    def __str__(self):
        return str(self.rent)

class Tongji(models.Model):
    class Meta:
        verbose_name = 'Statistics'
        