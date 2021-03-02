# Base your contaier on something of use and,
# by convention, launch your run-time logic
# from a 'docker-entrypoint.sh' shell-script.
#
# Note: Regardeless of the user you have avalable at build-time,
#       the container's actual user ID and group ID will be assigned by the
#       Data Tier Manager ... so plan accordingly.

ARG from_image=python:3.9.2-slim-buster
FROM ${from_image}

# Set expected environment variables to default values.
# The actual values are set by the DataTier Manager at run-time.
ENV DT_DATASET_ID=1
ENV DT_ERROR_TEXT_FILE=/dataset/output/error.txt

# All formatter images MUST place their
# implementations (and expect to start) in /home/format-support
WORKDIR /home/format-support

# Inject the entrypoint,
# making sure anyone can read and execute it.
COPY docker-entrypoint.sh ./
RUN chmod a+rx ./*.sh

# Start the formattter
CMD ./docker-entrypoint.sh
