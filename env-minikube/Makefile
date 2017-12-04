include ../Makefile

build: clean
	helm repo add chartmuseum $(CHART_REPO)
	helm repo update

install: clean build
	helm install chartmuseum/${CHART} --name $(NAME) -f ./myvalues.yaml -f ./secrets.yaml --version ${CHART_VERSION}
	watch kubectl get pods

upgrade: clean build
	helm upgrade $(NAME) chartmuseum/${CHART} -f myvalues.yaml -f secrets.yaml --version ${CHART_VERSION}
	watch kubectl get pods