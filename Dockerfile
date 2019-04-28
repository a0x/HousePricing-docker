FROM ruby:2.6.2
MAINTAINER AlvinQi<peng.edy@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs git

RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
ENV LANG en_US.UTF-8

RUN mkdir /app
RUN cd /app && git clone https://github.com/a0x/HousePricing
WORKDIR /app/HousePricing

RUN bundle install

COPY ./entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
