# Specify the base image to use for the container
FROM node:alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy all the files from the current directory to the working directory in the container
# If we wanted to copy only specific files or directories, we could specify them individually
# Example: COPY package.json .
# Same for the destination directory, by default it is the working directory, but we can specify a different one
# Example: COPY package.json ./other-directory
COPY . .

# Install the dependencies for the application
RUN npm install

# Expose the port that the application is running on in the container
EXPOSE 3000

# Run the application in the container
CMD [ "npm", "run", "start" ]
