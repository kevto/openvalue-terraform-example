CREATE TABLE public.talk (
    id bigint NOT NULL,
    speaker varchar NULL,
    description varchar NULL,
    title varchar NULL,
    CONSTRAINT talk_pk PRIMARY KEY (id)
);

CREATE TABLE public.talk_vote (
    id varchar NOT NULL,
    value int4 NOT NULL,
    talk_id bigint NOT NULL,
    CONSTRAINT talk_vote_pk PRIMARY KEY (id),
    CONSTRAINT talk_vote_fk FOREIGN KEY (talk_id) REFERENCES public.talk(id)
);
