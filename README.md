# A Docker image for [Hugo](https://gohugo.io) development

Hugo development environment with common tools, including Node.js, Typescript, Fontcustom, Cucumber, Capybara and Selenium.

See https://hub.docker.com/r/endian/hugo.

Example Drone.io usage:

```
pipeline:
    build-production:
      image: endian/hugo:1.0.1
      environment:
        - HUGO_ENV="production"
        - HUGO_BASEURL="https://endian.io"
      commands:
        - make docker-build
      when:
        branch: [master]
        event: [push, tag]
```

