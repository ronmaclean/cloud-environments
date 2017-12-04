include ../Makefile

build: clean
	helm repo add chartmuseum $(CHART_REPO)
	helm repo update
	helm secrets dec secrets.yaml

install: clean build
	helm install chartmuseum/${CHART} --name $(NAME) -f ./myvalues.yaml -f ./secrets.yaml.dec --version ${CHART_VERSION}
	watch kubectl get pods

upgrade: clean build
	helm upgrade $(NAME) chartmuseum/${CHART} -f myvalues.yaml -f secrets.yaml.dec --version ${CHART_VERSION}
	watch kubectl get pods