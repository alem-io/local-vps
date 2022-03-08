# local-vps

Этот проект нужен в образовательных целях для запуска VPS серверов на локальном компьютере.

VPS сервер запускается по указанному порту и принимает ssh подключение.

Для запуска локального сервера:

```bash
PORT=22 && docker run -d --rm \
    --name local-vps-$PORT \
    -p $PORT:$PORT \
    -v /var/run/docker.sock:/var/run/docker.sock \
    atlekbai/local-vps $PORT
```

### Подключение по ssh

Чтобы подключиться по `ssh` выполнить следующую команду:

```bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@127.0.0.1 -p 22
```

Пароль - `password`

Объяснение флагов:

- `-o StrictHostKeyChecking=no` не проверять сервер на подмену.
- `-o UserKnownHostsFile=/dev/null` указывает путь куда записывать host key. В данном случае в никуда `/dev/null`.

Без этого, если запускать новый VPS контейнер то при подключении не пройдет верификацию и наш клиент сбросит подключение, так как в нашем компьютере сохранился host key от предыдущего контейнера.
