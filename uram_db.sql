PGDMP  0                
    |            urm_db    16.3    16.3 )    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16462    urm_db    DATABASE     �   CREATE DATABASE urm_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE urm_db;
                postgres    false            O           1247    16464 
   user_types    TYPE     B   CREATE TYPE public.user_types AS ENUM (
    'Admin',
    'API'
);
    DROP TYPE public.user_types;
       public          postgres    false            �            1259    16512    roles    TABLE     �   CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying NOT NULL,
    created_by character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    16524 	   roles_api    TABLE     !  CREATE TABLE public.roles_api (
    id integer NOT NULL,
    role_id integer,
    role_name character varying NOT NULL,
    api character varying NOT NULL,
    type character varying NOT NULL,
    details text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.roles_api;
       public         heap    postgres    false            �            1259    16523    roles_api_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_api_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.roles_api_id_seq;
       public          postgres    false    220            �           0    0    roles_api_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.roles_api_id_seq OWNED BY public.roles_api.id;
          public          postgres    false    219            �            1259    16511    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    218            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    217            �            1259    16493    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying,
    phone character varying,
    password character varying NOT NULL,
    api_token character varying,
    type public.user_types NOT NULL,
    details text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    847            �            1259    16492    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    216            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    215            �            1259    16539 
   users_role    TABLE       CREATE TABLE public.users_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    username character varying NOT NULL,
    role_name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.users_role;
       public         heap    postgres    false            �            1259    16538    users_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_role_id_seq;
       public          postgres    false    222            �           0    0    users_role_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_role_id_seq OWNED BY public.users_role.id;
          public          postgres    false    221            /           2604    16515    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            1           2604    16527    roles_api id    DEFAULT     l   ALTER TABLE ONLY public.roles_api ALTER COLUMN id SET DEFAULT nextval('public.roles_api_id_seq'::regclass);
 ;   ALTER TABLE public.roles_api ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            ,           2604    16496    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            3           2604    16542    users_role id    DEFAULT     n   ALTER TABLE ONLY public.users_role ALTER COLUMN id SET DEFAULT nextval('public.users_role_id_seq'::regclass);
 <   ALTER TABLE public.users_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �          0    16512    roles 
   TABLE DATA           F   COPY public.roles (id, role_name, created_by, created_at) FROM stdin;
    public          postgres    false    218   �.       �          0    16524 	   roles_api 
   TABLE DATA           [   COPY public.roles_api (id, role_id, role_name, api, type, details, created_at) FROM stdin;
    public          postgres    false    220   D/       �          0    16493    users 
   TABLE DATA           w   COPY public.users (id, username, email, phone, password, api_token, type, details, created_at, updated_at) FROM stdin;
    public          postgres    false    216   �0       �          0    16539 
   users_role 
   TABLE DATA           [   COPY public.users_role (id, user_id, role_id, username, role_name, created_at) FROM stdin;
    public          postgres    false    222   �3       �           0    0    roles_api_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.roles_api_id_seq', 9, true);
          public          postgres    false    219            �           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 15, true);
          public          postgres    false    217            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 9, true);
          public          postgres    false    215            �           0    0    users_role_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_role_id_seq', 24, true);
          public          postgres    false    221            D           2606    16532    roles_api roles_api_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.roles_api
    ADD CONSTRAINT roles_api_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.roles_api DROP CONSTRAINT roles_api_pkey;
       public            postgres    false    220            @           2606    16520    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    218            B           2606    16522    roles roles_role_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);
 C   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_role_name_key;
       public            postgres    false    218            6           2606    16510    users users_api_token_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_api_token_key UNIQUE (api_token);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_api_token_key;
       public            postgres    false    216            8           2606    16506    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    216            :           2606    16508    users users_phone_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_key;
       public            postgres    false    216            <           2606    16502    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            F           2606    16547    users_role users_role_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.users_role
    ADD CONSTRAINT users_role_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.users_role DROP CONSTRAINT users_role_pkey;
       public            postgres    false    222            >           2606    16504    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    216            H           2606    16553    users_role fk_role    FK CONSTRAINT     �   ALTER TABLE ONLY public.users_role
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.users_role DROP CONSTRAINT fk_role;
       public          postgres    false    4672    222    218            I           2606    16548    users_role fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.users_role
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.users_role DROP CONSTRAINT fk_user;
       public          postgres    false    216    4668    222            G           2606    16533     roles_api roles_api_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.roles_api
    ADD CONSTRAINT roles_api_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.roles_api DROP CONSTRAINT roles_api_role_id_fkey;
       public          postgres    false    220    218    4672            �   �   x�}α�0E�9�
vT�~��&kaD�"�J,���'a�Z����������n����6�(Am�N��SD��RU+�璼s�r��>�����p��V�����K����Ƿ<@f���c� O
7�      �   .  x���An�0����Wv��8�!H��"���M7	um�Q�q��T�������_���|��������9��������1/ 0��	�0�h�Dp���>QQ

�����lc��k�����f�/[o�bX.V��Ƞ���J� *@XL�Bm���Nq��֮ݖG����<۷�c����y�_�d�4)r
��	����m����J��tJ����w�4�*k�q1��)@�|��LeA� ���<�l��{w-{h���j#J�FDFj�HM$�]�}8����������f0FFGԄ'�GQ�ac�a      �   �  x�}�[OG��w�yU����y"�@NNp�%KV�mE̲9��S8�EݣM�L��������������n��뻫�ĔD'�pa�ݭևi������pA=5M��&��I(�kR��*�\���H#��zE��m�e�j��[�i`�&� j5�H���2���&�4�.łA����o;&����=�	�D�d������ev{ӯ?���������`����|��M$���)SFH�
���T�T�Y��%�/̮ ��a9vq�\�D�$xb,1��e4E��MB��-@�c��A����&�)�)ʒ�s�{�S�)�%��v��鼯������mi˺Y� �" jЗ8~���_6g��_�����tQJ��P�V�6\"����,�����k*��RQ�F��C.���R���{n�V��q7to[�a*��
�C�Ʀ-Y2́�7�~��k}k�7�����3�1d�W��Di�1*����'S���v{��|y`�Z.TOO.�ޯ�!ܽ=:�X��)&��
7-�r����YLzJ�9R��bR>jShDҺ7I�����C{�K��Z%���0=:�_$�R�4L�؉��y$��)y���<=�O�����>9$�9jH/q@����O����Z�m C��[Ϲs�x�����L�F�Y��Dݏ�C`���\s�L➉"��ր�ID��<�Z����&�.��
���D��Ar�/lA����b~�̧�|>�b9T�      �   �   x��нNC1�9�)��Z���kaD]��,�@�}ݠ��\���}r�p�r�z}9ߞ����0r�m�o�"_u v�7ha���xz?�_\�j���6m�Ki��WA��&<|M����wx3��[�љ��Pf��
$*h�{z���߳ ��r��:�~��)'�2�rC�tr��)s�3���\�ixI��_'�`Fh��:��S��^��,��_Q��˲� �6o�     