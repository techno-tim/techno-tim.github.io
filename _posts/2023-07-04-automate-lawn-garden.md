---
layout: post
title: "I Automated Watering My Lawn & Garden!"
date: 2023-07-04 08:00:00 -0500
categories: vlog
tags: home-assistant homekit lawn weather gardening
image:
  path: /assets/img/headers/lawn-garden-header.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APy4/Zy8X6V4e/Zp+Onhu68EeFPENx4yTTFvPFWtaTpt/wCLfD40INfWB8E61fafeTeHGuLm8lbVmK6ib1YrQ239nzQNNL/MVGpRjlOa82FoVJVeWLqVIQlVpRpLniqFRwvT5nf2j95y+y4WPwLB+y/s3HKVCnNz5IucoxlUh7O0o+ynKDdO7k3P4r6cvJrf5+Tz5EV/tMi71V9ojt8LuAOB+6HAzjoPpXwkqlNNp0m2m02qk1d33trb06HEk0kuZ6Ly/wAj/9k=
---

This week I finally decided to automate the watering of my lawn and garden without irrigation, here’s how...

{% include embed/youtube.html id='jjUxJH3NWRs' %}
📺 [Watch Video](https://www.youtube.com/watch?v=jjUxJH3NWRs)

## Automation Without Irrigation

Since I don’t have irrigation, I have to use hoses, but that’s OK because I picked up these hose faucet timers. They’re great because you can hook them up to any hose faucet. I picked up this manifold and connected 4 of these faucet timers, one for each zone. As you can see I also split one zone into 2, we’ll talk about that in a sec. I can program each zone in the b-hyve app app to turn on each individually, and these sprinklers have a ton of watering options. The app also takes into consideration the rainfall so you’re not wasting water. And it’s not just for lawns, I also automated watering my garden giving it just the right amount of water each day. These soakers, along with a pressure reducer, help deliver water exactly where I want it. The soakers also works great for flower boxes that doesn’t receive any rain. If you’re a geek like me, you can even connect this to [Home Assistant](https://www.home-assistant.io/) or even [HomeKit](https://www.apple.com/home-app/).

If you're looking for the Home Assistant plugin I used to managed these timers, you can [find it here](https://github.com/sebr/bhyve-home-assistant) Don't forget to ⭐ the repo!

![4 port manifold!](/assets/img/posts/lawn-garden-manifold.webp){: w="338" h="600" lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIABIACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APrb9p34fwS/Fb4GaFB408N6ZpsOv6wfiRpX2vw3q2mWWjRaZpV3piaq8fiey0/4dSTSSm70fXptKuDcJD9gsdOt7u4stag/k3K88rYGjjascPh6zxlHkw08Z9Yw+JverGpPDUvqlVYt3TVaiqlFL2Uqjrc1OdCr+jcZ8BYDjjD5Tl2aZjneCw2T53gs4rUsizBYSlj3gGqtHA5nWo1I1HgZ1HTm4K8pT9nOChUjRrUvtCH4Nah5UXlQa7JH5aeXIbvw3OXTaNjmc+aZiy4JlMkhkJ373zuPhvMGm1/aFKNm1y/WIrls9rc6tbbZeh9r7DEPVYWbT1T9lU1T2fzP57/+Ce/wj8C/t0/tG6ZZ/Enxr4o0jwlqNpqHxD1LQvBXinWvCDXNhqFheeKZNLvNG8Q6944g0/R7nX28NXXiG21LWdae1vtR03TtB1prE+GLvTv7Jr5blLp5BSq0YUsVnGHzGrJRoUKtPDwoYKhRjTwtSphX7BUKOJpRoU6sbzhFylTklUifjNJ42Mc2xMJ2w+WYjB05t15QlKdevUnF1Yxrr26q1aU3UnBtQlKC505wkeqeI/2LfhVY+IdesvDf7acXh7w7Z6zqlroGgXmsa7qF3oei299PDpWj3V/ceKlnvbjTLFILKe7nUTXMsDTSAO7Cvw7E+KGGwuJxGGlkVDEyw9erQliJZbW5q7pVJU3WlyUow5qrjzvlio3l7qSsj9Ww/hrmFfD0Kyr1oKtRpVVCOb4ZKCqQjNRSbk0o3sk22ktW3qfhR+y1478ceHf2u/2dv+Ef8ZeK9C36F8C7J/7H8Q6vpm+zvprG1vbRvsV5Butry2urm3uoDmK4guJ4ZkeOaRW9HGVq1HJeIMTRq1KOIwtDjD6tiKU5U62Htl/P+4qwaqUvfhCX7uUfejGW8U1phKVKtnWU4arTp1cPiMTwiq+HqQjOjW/4UKkP3tKScKnuSlH34y92Uo7No/czxfrWsx+LPFEceramkaeItbRES/ulREXUrlVVVWUKqqoAVQAAAABiv5wotujSbbbdODbbu23FNtt6tt7s/dKqSqVEkklOaSWiSUnZJdEj/9k=" }
_Here's the 4 port manifold I used to create 4 zones_

![4 zones!](/assets/img/posts/lawn-garden-4-zones.webp){: w="338" h="600" lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIABIACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APqDxx8TvEGlfEj4mfBbUvDPia51+0/sjVdB1D4XWPhx9Q8N/DG60LQdR8Q+Nddl8V614esoNUTWr2bwfoel29zcXGqeJ7vw7Y2bnXtTsdNu/wAeyrLY4p0sb7Ct/ZOFo18Vj8QlVxDqww0pe1pYWjQpyq1JezipyjT56k3ejTTqzpKX3+PxOKw0sbQ+tUXVrxw1HLsNRws1icPVkqntqlao61RYl1ualHD0o4am6U4ynL26naj+QPiD/god/wAE59I17W9Kf4H/ABL8Svpmr6lp7eIzb+Ah/wAJA1leTWza3jVpLrVR/apiN/jU7q51Aef/AKbcTXPmSN7MMfxPUhGphcLk8cLUjGeGjOvGM40JJSoxlF0pcslTcVKPM7O6u9zyo5Xw40nicRnEsQ0nXlHCwknWa/etS+sPmTnzNSu7rU9T/a7/AGkr3TvA3j3x/wCH/G+p6v8AC6+bxofB41zTNDbWdffxprfhy31OztNYt7UXdh4P1jwZb6Bpd7o0uoyy3WoeF7l9QlfWY7NLXyMixdTNuI+HOHqlXEYTBxxkHjqWHrywtWhleIjKpXjUjSUvbYq+FliI4aoq9GVCrSh7CacqU/0HMMsw+S8M55nc4YfFY2phnRwFWrTjXpVM1oVKXI8POry8uHtiFRniKfsqkcRQq8lWMeWcf52oLvxHcQQ3CeFvDUqTxRzLKngfwDIsqyoHWRZH02N5FcMGDtHGzAhmRSSo/T54XJaM5Uq2d4anVpSlTq06ixKqU6kG4zhNRwdSKnGScZKM5xUk0pyWr+EhLNakIVKWTValKpCM6VSNOjONSnJKUJxlPGRlKMotSUpRjJp3cU20foD+1PNK37EHwYBlkIk+FPwKupAXYh7nXvDC6rrlw4J+afWdU03TtS1WU5k1G/sLK8vGmuLWCSP804MSlxzVckpOHE+ZU4uSu408PXjSoQi3tCjSrVqVKKtGnTq1IQSjOSf6FxdJx4MwUYtxjPhvKKklFtKU8RSdWvOSWjnWqUaNSrJ3dSdKnObcoRa+OfDNpat4b8PM1tbszaHpLMzQxlmY2FuSSSuSSeSTyTya9nPdM8zlLRLNcxSS0SSxlZJJLRJLZHz+Vyk8sy5uTbeAwjbbev8As9M//9k=" }
_Here are the 4 faucet timers I used to create 4 separate zones!_

![sprinklers in action!](/assets/img/posts/lawn-garden-sprinkler.webp){: w="338" h="600" lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIABIACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APQ7L4ia1pPx41ZviB4g074m/Du78A6fdeIde8LxpDaXOv8AnfEQ6XaxaDBa2ttosN3pem6abiWQxre614cnlWG3CJ9u/OcixGCy/N45nHK/qn1zLngcbVrYyjjcUqGBrRrZfgqmJoQip04YjMMbWgnTSc5RUnzxi187m0sNmeKxmLyhV54VrCR9rHLM0wVJTouca1K2YRdVTl7eE4U5VpurGMpQUo03GHH3ulfAO9vLu8SC5ZLu5nuUabUrV5mWeV5VaVn1iNmlIcGRmRGLZJRTkD9CXGGGh7ilGKj7qj/ZjlZR0S5tea1rc13fe7Pl5Ydc0rwqX5nf/a6q1vroo2WvbQ9A/aP/AGqfF3wo+Kf7M118MvDVl4lvPiN8YtH8IeOvD3i3Wrm5toPhtdaHrlt4h8Q6V4Ts/FkunWNzp1s7ajf6n/wio0+1uY4Lu8vfthS6X/Ivwg8McJg8DxnXzbMpYmeT8JZ4sjrYWLnVoZ/iKcaOFljMZDBfXMWqVSpJ4bBSzOc05+zp0PZRjBfaPh/BU6GGlSzarBTr0uem4Sanf20HJ037fmjKnU9o5UYyqxcoOnKUp2l9DN/wUQ+DVszW91D4PjuYGMNzHH4j8GGNJ4jsmSMyahFIUWRWC74on2gbo0bKjxP+IDcX1v30c7zGcav7yM1HM6XPGfvKfslpT5k7+zWkL8q2N45FlTSf1jBu6Tu62KV7q97RwTir76Nrs2j8PPFV5d6x+0H4JudXurjVLmH4aSxw3Gozy308UdxJNcTxxy3LSyIk9xPPPMqsFkmmllcM8jsf1PJYQwvh3nSw0Y4dPMqc2qEVSvNUowUv3aj7yhGMFLdQjGN7JI+cxcV9XlotEmtFp+/hHT/t1uP+FtbH0/fWlrDe3kUVtbxRRXVxHHHHDGkccaSuqIiKoVERQFVVAVVAAAAr57Ce9hcNKXvSlh6MpSlrKUnTi223q23q29W9WKEVyR0Xwx6Lsj//2Q==" }
_Here are the sprinklers in action! Highly recommend these because they have a ton of watering options and they are silent_

## Where to Buy

- Orbit B-hyve Smart Hose Faucet Timer with Hub - <https://amzn.to/3O2BqxW>
- Orbit B-hyve Smart Hose Faucet Timer - <https://amzn.to/43e0A0y>
- Orbit Hose Faucet Manifold - <https://amzn.to/3XGUbtJ>
- Orbit Gear Drive Sprinkler - <https://amzn.to/3JIMgqf>
- Flat Soaker Hose - <https://amzn.to/3PLtLFh>
- Hose Bibb Connector Backflow Preventer Vacuum Breaker - <https://amzn.to/3JLeuR8>
- Drip Irrigation 25 PSI Pressure Regulator - <https://amzn.to/44suD5V>
- Garden Hose Connector 90 Degree Brass Garden Hose Elbow - <https://amzn.to/3NXc2JN>
- Garden Hose Splitter - <https://amzn.to/3raafrP>
- Plumbers Tape - <https://amzn.to/3pHEdTw>
- Black Heavy Duty Cold Water Garden Hose - <https://amzn.to/3pHI6I9>

See the whole kit here! - <https://kit.co/TechnoTim/automated-lawn-and-garden-care>

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I Automated Watering my Lawn &amp; Garden! Have I gone too far with automation???<a href="https://t.co/HcPdCNKXbJ">https://t.co/HcPdCNKXbJ</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1675997477869088768?ref_src=twsrc%5Etfw">July 3, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
