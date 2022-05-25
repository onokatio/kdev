# onokatio/kdev

kdevやkpubに関する全資源を集約するモノレポジトリ。

## kdev

総合データセンター環境。

- アプリケーションを最小限の手間で展開できる環境を提供する。
	- 仮想マシンや、実行ファイル単体の実行（サーバーレス環境）、ロードバランサ、ドメイン、IPアドレス、など様々な資源を提供する。
- 死活監視やログ集約、アラートなど、管理の手間も最小限にする。

## kpub

公衆向けサービス。

- kdevの環境を使い、インターネットに公開される様々なサービス群。

## topolvm lvm management

```
sudo pvcreate /dev/sda1
sudo vgcreate topolvm /dev/sda1
```
# k8s-deployments

k8sのリソースを管理する。helmから取ってきたyaml群を保管する。

## 新しいパッケージを追加する手順

helmのカスタマイズで十分な場合

1. チャート名のディレクトリを作って移動する。
2. `helm inspect values repo/package > config.yaml`
3. `helm inspect all repo/package` 等を見ながら`config.yaml`をカスタマイズする。
4. `helm install <release-name> -f config.yaml repo/package`

## Repository

```
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add apphub https://apphub.aliyuncs.com
helm repo add codimd https://helm.codimd.dev/
helm repo add elastic https://helm.elastic.co
helm repo add ibm https://raw.githubusercontent.com/IBM/charts/master/repo/stable
helm repo add ibm-entitled https://raw.githubusercontent.com/IBM/charts/master/repo/entitled
helm repo add ibm-community https://raw.githubusercontent.com/IBM/charts/master/repo/community
helm repo add gitlab https://charts.gitlab.io/
helm repo add aws https://aws.github.io/eks-charts
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add microsoft https://microsoft.github.io/charts/repo
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add privatebin https://privatebin.github.io/helm-chart
helm repo add prometheus-com https://prometheus-community.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add jetstack https://charts.jetstack.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add topolvm https://topolvm.github.io/helm/
```
