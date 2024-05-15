FROM node:16-alpine AS build
WORKDIR /app
COPY ./  /app/
RUN node -v
RUN npm install --legacy-peer-deps
RUN npm -v
RUN npm run build
 
### STAGE 2: Run ###
FROM nginx:1.26.0-alpine
EXPOSE 4400
COPY --from=build /app/dist/ /usr/share/nginx/html
COPY ./default.conf /etc/nginx/conf.d/default.conf