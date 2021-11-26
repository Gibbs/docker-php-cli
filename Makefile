BUILD_NAME   := genv/php-cli
BUILD_DATE   := $(shell date -u "+%Y%m%dT%H%M%SZ")
PHP_VERSIONS := 5.6 7.0 7.1 7.2 7.3 7.4 8.0 8.1

build: build-php56 build-php70 build-php71 build-php72 build-php73 build-php74 build-php80 build-php81 push
.PHONY: build

build-php56:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=jessie \
		--build-arg PHP_PACKAGES="php5-cli php5-gd php5-imagick php5-mysql" \
		-t $(BUILD_NAME):5.6 \
		-t $(BUILD_NAME):5.6-$(BUILD_DATE) \
	.;
.PHONY: build-php56
.SILENT: build-php56

build-php70:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=stretch \
		--build-arg PHP_PACKAGES="php7.0-cli php7.0-dom php7.0-gd php7.0-imagick php7.0-mbstring php7.0-mysql php7.0-xml" \
		-t $(BUILD_NAME):7.0 \
		-t $(BUILD_NAME):7.0-$(BUILD_DATE) \
	.;
.PHONY: build-php70
.SILENT: build-php70

build-php71:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=stretch \
		--build-arg PHP_PACKAGES="php7.1-cli php7.1-dom php7.1-gd php7.1-imagick php7.1-mbstring php7.1-mysql php7.1-xml" \
		-t $(BUILD_NAME):7.1 \
		-t $(BUILD_NAME):7.1-$(BUILD_DATE) \
	.;
.PHONY: build-php71
.SILENT: build-php71

build-php72:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=stretch \
		--build-arg PHP_PACKAGES="php7.2-cli php7.2-dom php7.2-gd php7.2-imagick php7.2-mbstring php7.2-mysql php7.2-xml" \
		-t $(BUILD_NAME):7.2 \
		-t $(BUILD_NAME):7.2-$(BUILD_DATE) \
	.;
.PHONY: build-php72
.SILENT: build-php72

build-php73:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=buster \
		--build-arg PHP_PACKAGES="php7.3-cli php7.3-dom php7.3-gd php7.3-imagick php7.3-mbstring php7.3-mysql php7.3-xml" \
		-t $(BUILD_NAME):7.3 \
		-t $(BUILD_NAME):7.3-$(BUILD_DATE) \
	.;
.PHONY: build-php73
.SILENT: build-php73

build-php74:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=buster \
		--build-arg PHP_PACKAGES="php7.4-cli php7.4-dom php7.4-gd php7.4-imagick php7.4-mbstring php7.4-mysql php7.4-xml" \
		-t $(BUILD_NAME):7.4 \
		-t $(BUILD_NAME):7.4-$(BUILD_DATE) \
	.;
.PHONY: build-php74
.SILENT: build-php74

build-php80:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=buster \
		--build-arg PHP_PACKAGES="php8.0-cli php8.0-dom php8.0-gd php8.0-imagick php8.0-mbstring php8.0-mysql php8.0-xml" \
		-t $(BUILD_NAME):8.0 \
		-t $(BUILD_NAME):8.0-$(BUILD_DATE) \
		-t $(BUILD_NAME):latest \
	.;
.PHONY: build-php80
.SILENT: build-php80

build-php81:
	docker build \
		--no-cache \
		--build-arg DEBIAN_CODENAME=buster \
		--build-arg PHP_PACKAGES="php8.1-cli php8.1-dom php8.1-gd php8.1-imagick php8.1-mbstring php8.1-mysql php8.1-xml" \
		-t $(BUILD_NAME):8.1 \
		-t $(BUILD_NAME):8.1-$(BUILD_DATE) \
		-t $(BUILD_NAME):latest \
	.;
.PHONY: build-php81
.SILENT: build-php81

push:
	for PHP_VERSION in $(PHP_VERSIONS); do \
		docker push $(BUILD_NAME):$$PHP_VERSION; \
		docker push $(BUILD_NAME):$$PHP_VERSION-$(BUILD_DATE); \
	done
	docker push $(BUILD_NAME):latest
.PHONY: push
.SILENT: push

test:
	for PHP_VERSION in $(PHP_VERSIONS); do \
		VERSION=`docker run -ti $(BUILD_NAME):$$PHP_VERSION | grep ^PHP | cut -d' ' -f2`; \
		echo $$VERSION; \
		if [[ "$$PHP_VERSION" != *"$(VERSION)"* ]]; then \
			echo "$$PHP_VERSION not matched in: $$VERSION"; \
			exit 1; \
		fi; \
	done
.PHONY: test
.SILENT: test
