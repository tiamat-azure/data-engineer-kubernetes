#!/bin/bash

# Afficher un message de bienvenue avec figlet
figlet "Dev Container - Bienvenue"

# Afficher la version de l'image de base
uname -a

# Supprimer le cluster k3d mycluster s'il existe
k3d cluster delete mycluster

# Creer le cluster k3s
k3d cluster create mycluster

# Creer les ressources k8s pour le namespace 'standard'
kubectl apply -f yaml-standard/all-standard.yaml

# Se positionner par defaut sur le namespace 'standard'
kubectl config set-context --current --namespace=standard

# Consulter le contexte courant
# kubectl config current-context

# Consulter le detail du contexte courant et les autres contextes
# kubectl config get-contexts $(kubectl config current-context)

# Consulter les logs de tous les pods fastapi
kubectl logs -l app=fastapi --all-containers=true --tail=20 --prefix > yaml-standard/logs-fastapi.txt
kubectl logs -l app=pgadmin --all-containers=true --tail=20 --prefix > yaml-standard/logs-pgadmin.txt
kubectl logs -l app=postgres --all-containers=true --tail=20 --prefix > yaml-standard/logs-postgres.txt


# Creer les ressources k8s pour le namespace helm


# Creer les ressources k8s pour le namespace kustomize

