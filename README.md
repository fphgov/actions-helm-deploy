# HELM DEPLOY FOR K8S BY GITHUB ACTION

## Example pipeline
```yaml
on:
  push:
    branches:
      - master
jobs:
  deploy:
    runs-on: ["self-hosted"]
    steps:
      - uses: actions/checkout@master

      - name: 'Deploy'
        uses: 'fphgov/actions-helm-deploy@master'
        with:
          helm_repository_url: 'nexus.example.com'
          helm_repository_name: 'example-repo'
          helm_repository_alias: 'example-repo-alias'
          helm_repository_user: ${{ secrets.HELM_REPOSITORY_USER }}
          helm_repository_password: ${{ secrets.HELM_REPOSITORY_PASSWORD }}
          helm_repository_insecure: 'true'
          helm_chart: 'example-chart'
          namespace: 'example-namespace'
          app_name: 'example-app-name'
          kubeconfig: ${{ secrets.KUBECONFIG }}
          helm_values_file: 'values.yaml'
```

## Required Arguments

| variable                 | description                | required | default                     |
|--------------------------|----------------------------|----------|-----------------------------|
| helm_repository_url      | Helm repository url        | true     |                             |
| helm_repository_name     | Helm repository name       | true     |                             |
| helm_repository_alias    | Helm repository alias      | true     |                             |
| helm_repository_user     | Helm repository user       | true     |                             |
| helm_repository_password | Helm repository password   | true     |                             |
| helm_chart               | Helm chart name            | true     |                             |
| namespace                | App installation namespace | true     |                             |
| kubeconfig               | kubeconfig in string       | true     |                             |

## Optional Arguments

| variable                           | description                        | required | default |
|------------------------------------|------------------------------------|----------|---------|
| helm_chart_version                 | Helm chart version                 | false    |         |
| helm_repository_insecure           | Helm repository insecure mode      | false    | false   |
| helm_repository_login_extra_args   | Helm login extra arguments         | false    |         |
| helm_repository_upgrade_extra_args | Helm upgrade extra arguments       | false    |         |
| helm_values_file                   | Helm chart custom values file path | false    |         |

## License

MIT License

Copyright (c) 2022 Municipality of Budapest

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
