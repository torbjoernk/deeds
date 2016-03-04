#!/usr/bin/env bash

echo "Setting up Travis for DRIVER='${DRIVER}'"

cdir=`pwd`
cd $HOME

case "${DRIVER}" in
  firefox )
    echo "Using Firefox `firefox --version` from `which firefox`"
    ;;
  poltergeist )
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
    tar xf phantomjs-2.1.1-linux-x86_64.tar.bz2
    export PATH="${HOME}/phantomjs-2.1.1-linux-x86_64/bin:${PATH}"
    echo "Using PhantomJS `phantomjs --version` from `which phantomjs`"
    ;;
  * )
    echo "WARNING: Driver not set."
    ;;
esac

cd ${cdir}

if [[ "${DRIVER}" == "firefox" ]]; then
  export DISPLAY=:99.0
  sh -e /etc/init.d/xvfb start
  sleep 3
  /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile \
    --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16
  echo "XVFB server started"
else
  echo "XVFB not required for DRIVER='${DRIVER}'"
fi

if [[ "${WITH_FEATURES}" == "false" ]]; then
  bundle exec rspec --tag ~type:feature
else
  bundle exec rake spec
fi
