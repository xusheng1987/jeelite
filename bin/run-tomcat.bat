@echo off
title %cd%
echo.
echo [信息] 使用Spring Boot Tomcat运行工程。
echo.
rem pause
rem echo.

cd %~dp0
cd..

set MAVEN_OPTS=%MAVEN_OPTS% -Xms256m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m
call mvn clean spring-boot:run -Dmaven.test.skip=true

cd bin
pause