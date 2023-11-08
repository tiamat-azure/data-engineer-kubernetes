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

# Attendre 30 secondes
WAIT_TIME=40
echo 'Attendre '$WAIT_TIME' seconds le demarrage des pods...'
sleep $WAIT_TIME

# Consulter les logs
LOG=all-logs.txt

# Consulter les logs de PgAdmin
figlet "yaml-pgadmin" > $LOG
kubectl logs -l app=pgadmin --all-containers=true --tail=20 --prefix >> $LOG

figlet "yaml-postgres" >> $LOG
kubectl logs -l app=postgres --all-containers=true --tail=20 --prefix >> $LOG

figlet "yaml-fastapi" >> $LOG
kubectl logs -l app=fastapi --all-containers=true --tail=20 --prefix >> $LOG

# Tester un curl sur l'application FastAPI
figlet "Curl FastAPI" >> $LOG
kubectl run curl-container --image=radial/busyboxplus:curl -i --rm --restart=Never -- curl http://fastapi-svc.standard.svc.cluster.local >> $LOG

# Tester un curl sur l'application PgAdmin
figlet "Curl PgAdmin" >> $LOG
kubectl run curl-container --image=radial/busyboxplus:curl -i --rm --restart=Never -- curl http://pgadmin-svc.standard.svc.cluster.local:8080 >> $LOG

# Creer les ressources k8s pour le namespace helm


# Creer les ressources k8s pour le namespace kustomize

