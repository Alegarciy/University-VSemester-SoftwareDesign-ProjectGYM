FROM node:14

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Remove the build step since we're running in dev mode
# RUN npm run build

EXPOSE 4200

# Update the start command to allow external connections
CMD ["npm", "run", "start", "--", "--host", "0.0.0.0", "--disable-host-check"] 