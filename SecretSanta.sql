DECLARE
    -- Declare a table to store the names and email addresses of the participants
    TYPE participants IS
        TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    participant      participants;
    TYPE p_emails IS
        TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    p_email          p_emails;
    -- Declare a variable to store a random index
    random_index1    INT;
    random_index2    INT;
    temp_participant VARCHAR2(100);
    temp_email       VARCHAR2(100);
    creator          VARCHAR2(100) := 'Your Name';
BEGIN
    -- Declare variables to store the names,emails of the participants
    participant(1) := 'Person 1'; p_email(1) := 'p1@company.gr';
    participant(2) := 'Person 2'; p_email(2) := 'p2@company.gr';
    participant(3) := 'Person 3'; p_email(3) := 'p3@company.gr';
    participant(4) := 'Person 4'; p_email(4) := 'p4@company.gr';
    participant(5) := 'Person 5'; p_email(5) := 'p5@company.gr';
    participant(6) := 'Person 6'; p_email(6) := 'p6@company.gr';
    participant(7) := 'Person 7'; p_email(7) := 'p7@company.gr';
    participant(8) := 'Person 8'; p_email(8) := 'p8@company.gr';

    -- Shuffle the array of participants
    FOR i IN 1..8 LOOP
        random_index1 := dbms_random.value(1, 8);
        
        temp_participant := participant(i);
        participant(i) := participant(random_index1);
        participant(random_index1) := temp_participant;
        
        temp_email := p_email(i);
        p_email(i) := p_email(random_index1);
        p_email(random_index1) := temp_email;
    END LOOP;

    -- Print out the secret Santa assignments
    FOR i IN 1..8 LOOP
    /**
        -- Open a connection to the mail server
        mail_conn := utl_smtp.open_connection('your_mail_server', <port number>);
        -- Identify yourself to the mail server
        utl_smtp.helo(mail_conn, 'your_domain');
        -- Set the recipient email address
        recipient := p_email(i);
        -- Send the email
        utl_smtp.mail(mail_conn, 'secret_santa@your_domain.com');
        utl_smtp.rcpt(mail_conn, recipient);
        utl_smtp.data(mail_conn, 'Subject: Secret Santa Assignment'
                                 || utl_tcp.crlf 
								 || utl_tcp.crlf
                                 || 'Dear '
                                 || participant(i) 
								 || ': ' 
								 || p_email(i)
                                 || ', '
                                 || utl_tcp.crlf 
								 || utl_tcp.crlf
                                 || 'You will be buying a gift for '
                                 || participant(i MOD 8 + 1) 
								 || ': ' 
								 || p_email(i MOD 8 + 1)
                                 || '.'
                                 || utl_tcp.crlf 
								 || utl_tcp.crlf
                                 || 'Kind regards, '
                                 || utl_tcp.crlf
                                 || creator);
        utl_smtp.close_data(mail_conn);
        utl_smtp.quit(mail_conn);
    */    
        dbms_output.put_line(participant(i)
                             || ' will be buying a gift for '
                             || participant(i MOD 8 + 1) 
							 || ': ' 
							 || p_email(i MOD 8 + 1));
    END LOOP;

END;
