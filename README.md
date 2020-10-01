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
