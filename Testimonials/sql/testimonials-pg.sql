
SET ROLE web;

BEGIN TRANSACTION;
DROP TABLE IF EXISTS testimonial;
CREATE TABLE testimonial (
    id SERIAL PRIMARY KEY,
    testimonial TEXT,
    byline TEXT
);
INSERT INTO testimonial VALUES( DEFAULT, 'Don&#39;t count the days,  make the days count.', 'Muhammad Ali');
INSERT INTO testimonial VALUES( DEFAULT, 'Clothes make the man. Naked people have little or no influence on society. ', 'Mark Twain');
INSERT INTO testimonial VALUES( DEFAULT, 'Intelligence without ambition is a bird without wings. &#13;&#10;', 'Salvador Dali');
INSERT INTO testimonial VALUES( DEFAULT, 'One original thought is worth a thousand mindless quotings.', 'Diogenes of Sinope');
INSERT INTO testimonial VALUES( DEFAULT, 'Computers are useless. They can only give you answers.', 'Pablo Picasso');
INSERT INTO testimonial VALUES( DEFAULT, 'Action speaks louder than words but not nearly as often. ', 'Mark Twain');
INSERT INTO testimonial VALUES( DEFAULT, 'Be careful about reading health books. You may die of a misprint. ', 'Mark Twain');
INSERT INTO testimonial VALUES( DEFAULT, 'Analyzing humor is like dissecting a frog. Few people are interested and the&#13;&#10;frog dies of it. &#13;&#10;', 'E.B. White');
INSERT INTO testimonial VALUES( DEFAULT, 'Comedy has to be based on truth. You take the truth and you put a little&#13;&#10;curlicue at the end. &#13;&#10;', 'Sid Ceasar');
INSERT INTO testimonial VALUES( DEFAULT, 'Who are you going to believe,  me or your own eyes? &#13;&#10;', 'Groucho Marx');
INSERT INTO testimonial VALUES( DEFAULT, 'A countryman between two lawyers is like a fish between two cats. ', 'Benjamin Franklin');
INSERT INTO testimonial VALUES( DEFAULT, 'A computer once beat me at chess,  but it was no match for me at kick boxing. ', 'Amir Azimi');
INSERT INTO testimonial VALUES( DEFAULT, 'The most exciting phrase to hear in science,  the one that heralds new discoveries,  is not &#34;Eureka!&#34; but &#34;That&#39;s funny ...&#34; &#13;&#10;', 'Issac Asimov');
INSERT INTO testimonial VALUES( DEFAULT, 'I am not a number. I am a free man!', 'Number 6');
COMMIT;
