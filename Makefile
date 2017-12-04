CHART_REPO := http://chartmuseum.thunder.thunder.fabric8.io
CHART := helm-charts
CHART_VERSION := 0.0.7
OS := $(shell uname)
HELM := $(shell command -v helm 2> /dev/null)
NAME := projectx

setup:
	minikube addons enable ingress
ifndef HELM
ifeq ($(OS),Darwin)
	brew install kubernetes-helm
else
	echo "Please install helm first https://github.com/kubernetes/helm/blob/master/docs/install.md"
endif
endif
	helm init
	helm repo add chartmuseum $(CHART_REPO)

delete:
	helm delete --purge $(NAME)
	kubectl delete cm --all

clean:
	rm -rf secrets.yaml.dec