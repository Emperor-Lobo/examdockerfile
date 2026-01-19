# Docker Exam – WordPress / phpMyAdmin / MySQL

## Description
Ce projet est un serveur Docker tout-en-un configuré pour un l'examen.
Il contient plusieurs services fonctionnant simultanément dans un seul conteneur :

- Nginx (serveur web)
- WordPress
- phpMyAdmin
- MariaDB (MySQL)

Le serveur redirige automatiquement selon l’URL demandée.

---

## Services disponibles

| URL | Service |
|---|---|
| http://localhost | Page d’accueil (index.php) |
| http://localhost/wordpress | WordPress |
| http://localhost/phpmyadmin | phpMyAdmin |

---

## Fonctionnalités demandées

✅ Plusieurs services dans un même conteneur  
✅ Base de données fonctionnelle  
✅ Utilisateur SQL + base créée  
✅ Redirection selon l’URL  
✅ Index automatique activable/désactivable via variable d’environnement  
✅ Nginx + PHP-FPM + MariaDB  

---

## Variables d’environnement

```env
AUTOINDEX=on
