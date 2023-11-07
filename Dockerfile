ARG IMG_TAG=v3.x

FROM registry.cn-qingdao.aliyuncs.com/metersphere/metersphere:${IMG_TAG} as metersphere
FROM registry.cn-qingdao.aliyuncs.com/metersphere/task-runner:${IMG_TAG} as task-runner
FROM registry.cn-qingdao.aliyuncs.com/metersphere/result-hub:${IMG_TAG} as result-hub
FROM registry.cn-qingdao.aliyuncs.com/metersphere/alpine-openjdk21-jre as builder

COPY --from=metersphere /app /metersphere
COPY --from=task-runner /app /task-runner
COPY --from=result-hub /app /result-hub

COPY comm.sh /comm.sh

RUN chmod +x /comm.sh && /comm.sh

#
FROM registry.cn-qingdao.aliyuncs.com/metersphere/alpine-openjdk21-jre

COPY --from=builder /standalone /standalone  
COPY --from=builder /metersphere /metersphere
COPY --from=builder /task-runner /task-runner
COPY --from=builder /result-hub /result-hub

COPY --from=task-runner /opt/jmeter /opt/jmeter

ENV AB_OFF=true
ENV MS_VERSION=${MS_VERSION}

ADD start.sh /start.sh
ADD metersphere.sh /metersphere.sh
ADD task-runner.sh /task-runner.sh
ADD result-hub.sh /result-hub.sh

RUN chmod +x /start.sh
ENTRYPOINT ["sh", "/start.sh"]

