#!/bin/bash

echo -n "Contexto atual: "
kubectl config current-context
echo
echo "Caso o contexto esteja errado, execute:"
echo "- Verificar contextos disponíveis: 'kubectl config get-contexts'"
echo "- Alterar o contexto atual: 'kubectl config use-context CONTEXTO'"
echo
read -p "Pressione qualquer tecla para continuar..."

echo "Pods em 'Terminating':"
kubectl get pods -A | grep Terminating
echo

read -p "Realmente quer deletar estes pods? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    kubectl get pods -A | grep Terminating | while read namespace name status rest; do kubectl delete pod $name -n $namespace --force --grace-period=0; done
fi
