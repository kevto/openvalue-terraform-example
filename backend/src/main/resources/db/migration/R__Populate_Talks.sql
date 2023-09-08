INSERT INTO public.talk (id,speaker,description,title)
    VALUES (2,'Adam Michalik','What''s encoding exactly?','Encoding')
    ON CONFLICT (id) DO NOTHING;
INSERT INTO public.talk (id,speaker,description,title)
    VALUES (1,'Ali Meshkat','Best Kotlin Workshop','Become a Kotlin Guru')
    ON CONFLICT (id) DO NOTHING;
INSERT INTO public.talk (id,speaker,description,title)
    VALUES (3,'Kevin Berendsen','Gain new skills as a Terraform master','Master Terraform')
    ON CONFLICT (id) DO NOTHING;
