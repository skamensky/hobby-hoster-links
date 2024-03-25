# Builder stage
FROM alpine as builder

# Install Git
RUN apk add --no-cache git

RUN git clone https://github.com/sethcottle/littlelink.git
RUN ls /littlelink
RUN mkdir /assets
RUN cp -r /littlelink/css /assets/css
RUN cp -r /littlelink/fonts /assets/fonts
RUN cp -r /littlelink/images /assets/images
# custom override
COPY ./assets /assets

FROM nginx:alpine
COPY --from=builder /assets /usr/share/nginx/html
EXPOSE 80
# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
