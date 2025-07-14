from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ProjectViewSet, BlogViewSet,
    ExperienceViewSet, EducationViewSet,
    CertificationViewSet
)

router = DefaultRouter()
router.register(r'projects', ProjectViewSet)
router.register(r'blogs', BlogViewSet)
router.register(r'experiences', ExperienceViewSet)
router.register(r'education', EducationViewSet)
router.register(r'certifications', CertificationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
