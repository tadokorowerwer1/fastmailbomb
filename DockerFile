# PHP + Apache の公式イメージを使用
FROM php:8.2-apache

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv locales locales-all curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 日本語環境を設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    TERM=xterm

# 作業ディレクトリ
WORKDIR /bot

# 仮想環境の作成
RUN python3 -m venv /bot/venv

# 仮想環境のパスを有効化
ENV PATH="/bot/venv/bin:$PATH"

# pip のアップグレード
RUN pip install --upgrade pip

# requirements.txt をコピーしてインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# コードをコピー
COPY . .

# ポート開放
EXPOSE 80

# 実行（仮想環境を使用）
CMD ["python", "main.py"]
