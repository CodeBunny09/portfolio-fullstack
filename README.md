# 💼 Fullstack Personal Portfolio

A fullstack portfolio site built with:

- 🐍 Django + DRF backend (Dockerized)
- ⚛️ React frontend (Portfolio)
- 🛠️ React admin panel (Dashboard)
- 🐳 Docker (for local + production parity)
- 🌐 Netlify + Render for free hosting

---

## 📁 Folder Structure

```

portfolio-fullstack/
├── backend/         # Django + DRF + PostgreSQL (Dockerized)
├── frontend/        # React frontend for personal site
├── admin-panel/     # React dashboard for admin CRUD
├── setup.sh         # Bootstrap the full structure
├── git\_push.sh      # Automates GitHub commits & push
├── README.md        # This file

```

---

## ⚙️ Tech Stack

| Layer         | Stack                                  |
|---------------|-----------------------------------------|
| Frontend      | React, TailwindCSS, Framer Motion       |
| Backend       | Django, DRF, JWT Auth, PostgreSQL       |
| Admin Panel   | React, Axios, React-Hook-Form, Toastify |
| DevOps        | Docker, Docker Compose                  |
| Hosting       | Netlify (FE), Render (BE), GitHub       |

---

## 🧰 Setup Instructions

### 1. Clone + Run Setup

```bash
git clone https://github.com/YOUR_USERNAME/portfolio-fullstack.git
cd portfolio-fullstack
chmod +x setup.sh
./setup.sh
```


### 2. Backend (Django + Docker)

```bash
cd backend
cp .env.example .env
docker-compose up --build
```

### 3. Frontend (React)

```bash
cd frontend
npm install
npm start
```

### 4. Admin Panel

```bash
cd admin-panel
npm install
npm start
```

---

## 🧱 Roadmap

### ✅ Backend

* [x] Docker setup
* [ ] Models: Project, Blog, Experience, Education
* [ ] Serializers, ViewSets, URLs
* [ ] JWT Auth integration
* [ ] Deployment on Render

### ✅ Frontend

* [ ] Homepage, Projects, Blogs, About
* [ ] Auto-skill aggregation from API
* [ ] Add 3D animations (Three.js)

### ✅ Admin Panel

* [ ] Login via JWT
* [ ] Dashboard CRUD forms
* [ ] Edit blog, projects, experience

---

## 🌐 Deployment

| Component   | Host      | Notes                      |
| ----------- | --------- | -------------------------- |
| Backend     | Render    | Docker, PostgreSQL         |
| Frontend    | Netlify   | Connect repo, build React  |
| Admin Panel | Netlify   | Add environment variables  |
| Domain      | Hostinger | Use `.in` or `.xyz` domain |

---


## 👨‍💻 Author

**Pratik Choudhuri**

* AI/ML Intern @ Labmentix
* MCA @ Adamas University
* [LinkedIn](https://www.linkedin.com/in/pratik-c/) | [GitHub](https://github.com/CodeBunny09)
