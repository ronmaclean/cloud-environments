# projectX cloud environments

This repository contains a number of projectX environments including cloud specific configuration and encrypted production secrets that can be applied to any kubernetes cluster via a Makefile or Jenkins Pipelines.

# Prerequisits

Access to a kubernetes cluster and connected kubectl context so you can run `kubectl get pods` for example.  If you don't have access to a remote kubernetes cluster you can use minikube to run locally.

If you don't need minikube skip to the [helm](#helm) Prerequisits

## Minikube
First install minikube using these steps (tip if running on OSX use xhyve hypervisor) https://kubernetes.io/docs/tasks/tools/install-minikube/
```
minikube start --vm-driver hyperkit --cpus 4 --memory 4096
```

## Helm
We use [helm](https://github.com/kubernetes/helm) as the package manager and for it's install / upgrade features.  So first get the helm binary 

If you are on OSX simply run:
```
brew install kubernetes-helm
```
If not visit https://github.com/kubernetes/helm/blob/master/docs/install.md


Now if you are running against __minikube__ and this is the first time then run:
```
make setup
```
If you are running against a remote kubernetes cluster then you will need to first install the helm server side service [Tiller](https://github.com/kubernetes/helm#helm-in-a-handbasket), this can be done by running:
```
helm init
```

# Install

Fork and clone this repo and choose the the environment you wish to install into from the list below.  Then change directory into the matching environment and run `make install`.

List of environments:
- __minikube__ - this is the most popular way to kick the tires locally
- __GKE__ - this is on the Googles Container Engine public cloud
- __Thunder__ - this is projectX's own production CD infrastructure

## Examples:
Change directory into desired environment:
```
cd env-$CHOSEN_ENV
```
Now install:
```
make install
```
To upgrade:
```
make upgrade
```
To delete the projectX release from your target environment:
```
make delete
```
Now to access services running in minikube get the URLs by running:
```
kubectl get ingress
```

# Secrets

You may notice that the thunder/secrets.yaml is encrypted.  This means we can commit and push to github our production secrets so when we reprovision the environment we simply clone, helm decode and install / upgrade from a CI/CD pipeline.  More details on how to setup the helm wrapper and gpg keys so you can do this yourself on your own fork.

This means our entire cloud environments are competely recreatable and both configureation and secrets have a tracability and an adit trail.

## Credentials

The default credentials for test purposes are below, please either change the raw secrets.yaml files or follow the secrets section above to encrypt your own sensitive data.

| Application | Username | Password |
| ----------- |:--------:| --------:|
| Jenkins     | admin    | admin    |
| Nexus       | admin    | admin123 |

# Local developement

This repo is for installing a released platform version.  If you want to develop and contribute please head over to the https://github.com/ronmaclean/helm-charts repo.

# Manual installation