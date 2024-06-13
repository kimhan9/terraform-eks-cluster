# terraform-eks-cluster

Provision a EKS cluster with Terraform.

## Update `kubeconfig`

Once the EKS is provisioned, use following command to update `kubeconfig` on local machine to able interact with the cluster.
`aws eks --region ap-southeast-1 update-kubeconfig --name my-k8s`

## Install ArgoCD

Install ArgoCD on EKS
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Get ArgoCD CLI on local machine
`brew install argocd`

Get the password
`argocd admin initial-password -n argocd`

## Create an App on EKS

Set current namespace to argocd
`kubectl config set-context --current --namespace=argocd`

Port foward the API server without exposing the service.
`kubectl port-forward svc/argocd-server -n argocd 8080:443`

Login to ArgoCD CLI
`argocd login localhost:8080`

Deploy the example application
```
argocd app create my-retail-store --repo https://github.com/kimhan9/retail-store-sample-app.git --path dist/kubernetes --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy automated --self-heal
```

## Clean up

Delete example application
`argocd app delete my-retail-store`

Terraform
`terraform destroy`