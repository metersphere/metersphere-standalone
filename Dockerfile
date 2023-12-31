ARG IMG_TAG=v3.x

FROM registry.cn-qingdao.aliyuncs.com/metersphere/metersphere:${IMG_TAG}-community as metersphere
FROM registry.cn-qingdao.aliyuncs.com/metersphere/task-runner:${IMG_TAG} as task-runner
FROM registry.cn-qingdao.aliyuncs.com/metersphere/result-hub:${IMG_TAG} as result-hub
FROM registry.cn-qingdao.aliyuncs.com/metersphere/alpine-openjdk21-jre as builder

COPY --from=metersphere /app /metersphere
COPY --from=task-runner /app /task-runner
COPY --from=result-hub /app /result-hub

COPY shells /shells
RUN chmod +x /shells/comm.sh && /shells/comm.sh

#
FROM registry.cn-qingdao.aliyuncs.com/metersphere/alpine-openjdk21-jre

COPY --from=builder /standalone /standalone  
COPY --from=builder /metersphere /metersphere
COPY --from=builder /task-runner /task-runner
COPY --from=builder /result-hub /result-hub

COPY --from=task-runner /opt/jmeter /opt/jmeter
COPY --from=task-runner /usr/bin/node_exporter /usr/bin/node_exporter
COPY --from=metersphere /tmp/MS_VERSION /tmp/MS_VERSION

ENV AB_OFF=true

COPY shells /shells
RUN chmod +x /shells/*.sh 

ENTRYPOINT ["sh", "/shells/start.sh"]

