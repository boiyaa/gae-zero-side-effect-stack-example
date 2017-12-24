# gae-zero-side-effect-stack-example

```sh
$ git clone https://github.com/boiyaa/gae-zero-side-effect-stack-example.git
$ cd gae-zero-side-effect-stack-example
```

## Google App Engine

```sh
$ gcloud config set project your-project
```

## Back-end

### Build docker image

```sh
$ docker build -t gcr.io/gae-zero-side-effect-stack/web-api -f Dockerfile.build .
```

### Deploy docker image

```sh
$ gcloud docker -- push gcr.io/gae-zero-side-effect-stack/web-api
```

### Deploy app

```sh
$ gcloud app deploy
```

## Front-end

### Build

```sh
$ elm-make app/Main.elm --yes --output=public/main.js
```

### Deploy app

```sh
$ cd public
$ gcloud app deploy
```
