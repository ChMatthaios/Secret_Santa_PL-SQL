-- Create table for employees
DROP TABLE scs_employees;

CREATE TABLE scs_employees
(
    full_name    VARCHAR2 (100) NOT NULL,
    email        VARCHAR2 (100) NOT NULL
);

-- Inserts into employees

INSERT INTO scs_employees (full_name, email)
VALUES ('Full Name', 'email@example.com');
/* Add them all manually */

COMMIT;

--------------------------------------------------------------------------------

DECLARE
    TYPE employees IS TABLE OF VARCHAR2 (100)
        INDEX BY BINARY_INTEGER;

    TYPE emails IS TABLE OF VARCHAR2 (100)
        INDEX BY BINARY_INTEGER;

    employee     employees;
    email        emails;
    p_cnt        INT := 1;
    p_size       INT;
    rand_indx    INT;
    temp_emp     VARCHAR2 (100);
    temp_email   VARCHAR2 (100);
    creator      VARCHAR2 (100) := 'Creator''s Name';
BEGIN
    FOR i IN (SELECT full_name, email FROM scs_employees)
    LOOP
        employee (p_cnt) := i.full_name;
        email (p_cnt) := i.email;
        p_cnt := p_cnt + 1;
    END LOOP;

    p_size := p_cnt - 1;

    FOR i IN 1 .. p_size
    LOOP
        rand_indx := DBMS_RANDOM.VALUE (1, p_size);
        temp_emp := employee (i);
        employee (i) := employee (rand_indx);
        employee (rand_indx) := temp_emp;
        temp_email := email (i);
        email (i) := email (rand_indx);
        email (rand_indx) := temp_email;
    END LOOP;

    FOR i IN 1 .. p_size
    LOOP
        /**
        -- https://oracle-base.com/articles/misc/email-from-oracle-plsql
        -- Open a connection to the mail server
        mail_conn := utl_smtp.open_connection('your_mail_server', <port number>);
        -- Identify yourself to the mail server
        utl_smtp.helo(mail_conn, 'your_domain');
        -- Set the recipient email address
        recipient := email(i);
        -- Send the email
        utl_smtp.mail(mail_conn, 'secret_santa@your_domain.com');
        utl_smtp.rcpt(mail_conn, recipient);
        utl_smtp.data(mail_conn, 'Subject: Secret Santa '
                                 || utl_tcp.crlf
                                 || utl_tcp.crlf
                                 || 'Dear '
                                 || employee(i)
                                 || ', '
                                 || utl_tcp.crlf
                                 || utl_tcp.crlf
                                 || 'You will be buying a gift for '
                                 || employee(i MOD p_size + 1)
                                 || '.'
                                 || utl_tcp.crlf
                                 || utl_tcp.crlf
                                 || 'Kind regards, '
                                 || utl_tcp.crlf
                                 || creator);

        utl_smtp.close_data(mail_conn);
        utl_smtp.quit(mail_conn);
        */
        DBMS_OUTPUT.put_line ( employee (i) 
                               || ' -> ' 
                               || employee (i MOD p_size + 1));
    END LOOP;
END;
