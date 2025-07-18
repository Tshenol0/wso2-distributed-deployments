FROM wso2/wso2is:5.10.0

ENV IS_HOME=/home/wso2carbon/wso2is-5.10.0

COPY ./connector/mysql-connector-java-5.1.49.jar ${IS_HOME}/repository/components/lib/

COPY ./libs/wso2is.key.manager.core-1.0.15.jar ${IS_HOME}/repository/components/dropins/
COPY ./libs/wso2is.notification.event.handlers-1.0.15.jar ${IS_HOME}/repository/components/dropins/

COPY ./war/keymanager-operations.war ${IS_HOME}/repository/deployment/server/webapps