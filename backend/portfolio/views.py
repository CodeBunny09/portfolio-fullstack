from rest_framework import viewsets
from .models import Project, Blog, Experience, Education, Certification
from .serializers import (
    ProjectSerializer, BlogSerializer,
    ExperienceSerializer, EducationSerializer,
    CertificationSerializer
)

class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all().order_by('-start_date')
    serializer_class = ProjectSerializer

class BlogViewSet(viewsets.ModelViewSet):
    queryset = Blog.objects.all().order_by('-published_date')
    serializer_class = BlogSerializer

class ExperienceViewSet(viewsets.ModelViewSet):
    queryset = Experience.objects.all().order_by('-start_date')
    serializer_class = ExperienceSerializer

class EducationViewSet(viewsets.ModelViewSet):
    queryset = Education.objects.all().order_by('-start_year')
    serializer_class = EducationSerializer

class CertificationViewSet(viewsets.ModelViewSet):
    queryset = Certification.objects.all().order_by('-issue_date')
    serializer_class = CertificationSerializer
