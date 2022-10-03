# Dockerfile сборка образа
# установка базового образа
FROM python:3.10

# не позволяет Python буферизовать выходные данные
ENV PYTHONUNBUFFERED=1

# переменные сборки
ARG WORKDIR=/wd
ARG USER=user

WORKDIR ${WORKDIR}

# создание системного пользователя и установка владельца каталога WORKDIR
RUN useradd --system ${USER} && \
    chown --recursive ${USER} ${WORKDIR}

RUN apt update && apt upgrade -y

# копирование файлов
# не копир служебные файлы
COPY --chown=${USER} requirements.txt requirements.txt

# установка зависимостей
RUN pip install --upgrade pip && \
    pip install --requirement requirements.txt

# копирование файлов
COPY --chown=${USER} ./main.py main.py

# переключение на пользователя
USER ${USER}

# запуск
ENTRYPOINT ["python", "main.py"]