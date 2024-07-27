# 使用官方的 Python 镜像作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 将当前目录内容复制到容器的 /app 目录
COPY . /app

# 安装 Python 包依赖
RUN pip install -r requirements.txt

# 安装 GF 及其依赖项
RUN apt-get update && apt-get install -y wget gnupg software-properties-common make gcc

# 下载并编译 GF
RUN wget http://www.grammaticalframework.org/releases/gf-3.10/gf-3.10.tar.gz \
    && tar -xzf gf-3.10.tar.gz \
    && cd gf-3.10 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf gf-3.10 gf-3.10.tar.gz

# 暴露端口
EXPOSE 8080

# 设置 Flask 应用环境变量
ENV FLASK_APP=app.py

# 启动应用
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]
