## アプリケーションのビルドと実行

準備ができたら、アプリケーションを起動してください：
docker compose up --build`.

### アプリケーションをクラウドにデプロイする

まず、イメージをビルドします： docker build -t myapp .`.
クラウドが開発マシンと異なるCPUアーキテクチャを使用している場合、次のようにします。
クラウドがあなたの開発マシンと異なるCPUアーキテクチャを使っている場合（例えば、あなたはMac M1を使っていて、クラウドプロバイダーはamd64）、
そのプラットフォーム用にイメージをビルドする必要があります：
docker build --platform=linux/amd64 -t myapp .`.

そして、それをあなたのレジストリにプッシュします、例えば `docker push myregistry.com/myapp`.

Dockerの[getting started](https://docs.docker.com/go/get-started-sharing/)
docsを参照してください。

<www.DeepL.com/Translator（無料版）で翻訳しました。>
