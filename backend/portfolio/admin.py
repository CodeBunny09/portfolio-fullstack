from django.contrib import admin
from .models import Project, Blog, Experience, Education, Certification

# Register your models here.
from django.db import models

admin.site.register(Project)
admin.site.register(Blog)
admin.site.register(Experience)
admin.site.register(Education)
admin.site.register(Certification)