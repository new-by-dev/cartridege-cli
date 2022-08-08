# tarantool/cartridge-cli-docker

The docker is useful for build and push docker images with cartridge during CI processes, like Gitlab CI Jobs

The docker image which contains:
- tarantool
- cartridge-cli
- docker-ce-cli


#### Example: 
```yaml
.docker-registry-auth:
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  after_script:
    - docker logout $CI_REGISTRY
  
build-cartrdge:
  stage: build
  image: tarantool/cartridge-cli:latest
  script:
    - cartridge build
    - cartridge pack docker --version ${CI_COMMIT_TAG}
    - docker tag my_app:${CI_COMMIT_TAG} ${CI_REGISTRY_IMAGE}:${CI_COMMIT_TAG}
    - docker push ${CI_REGISTRY_IMAGE}:${CI_COMMIT_TAG}
  interruptible: true
  only:
    refs:
      - tags
```
