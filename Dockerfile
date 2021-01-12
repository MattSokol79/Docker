# Build this image from the official image of nginx
FROM nginx

# Label is used as a reference if you need to know who built this image
LABEL MAINTAINER=msokol@spartaglobal.com

# Copy index.html from our localhost to default location of index.html inside the container
COPY index.html /usr/share/nginx/html/

# Expose port 80 to launch in the browser
EXPOSE 80

# CMD run a command inside the container
CMD ["nginx", "-g", "daemon off;"]