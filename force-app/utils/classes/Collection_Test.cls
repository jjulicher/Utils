/**
 * Created by justinj on 21/09/2020.
 */
@IsTest
private class Collection_Test {

    @IsTest
    static void list_equalsSObjectField_shouldFilterRecords() {
        System.debug(Type.forName('List<Account>'));
        List<Account> testList = new List<Account>();
        testList.add(new Account(Name = 'Test123', AccountSource = 'Test123'));
        testList.add(new Account(Name = 'Test1234', AccountSource = 'share'));
        testList.add(new Account(Name = 'Test1235', AccountSource = 'Test1235'));

        List<Account> filtered = Collection.of(testList)
                .equals(Account.Name, 'Test1234')
                .equals(Account.AccountSource, 'share')
                .asSObjectList(new List<Account>());


        System.assertEquals(1, filtered.size());
        System.assertEquals('Test1234', filtered.get(0).Name);

    }

    @IsTest
    static void list_equalsValue_shouldFilterRecords() {
        System.debug(Type.forName('List<Account>'));
        List<Account> testList = new List<Account>();
        testList.add(new Account(Name = 'Test123', AccountSource = 'Test123'));
        testList.add(new Account(Name = 'Test123', AccountSource = 'Test'));

        for(Integer i = 20; i< 600;i++){
            testList.add(new Account(Name = 'Test1235'+i, AccountSource = 'Test1235'));
        }

        Long systemCurrentTimeMillis = System.currentTimeMillis();
        List<Account> filtered = Collection.of(testList)
                .equals(Account.Name, 'Test123')
                .equals(Account.AccountSource, 'Test')
                .equals(Account.AccountSource, 'Test')
                .equals(Account.AccountSource, 'Test')
                .equals(Account.AccountSource, 'Test')
                .asSObjectList(new List<Account>());

        System.debug('Time: ' + (System.currentTimeMillis() - systemCurrentTimeMillis));
        System.assertEquals(1, filtered.size());
        System.assertEquals('Test123', filtered.get(0).Name);
    }


    @IsTest
    static void testListSpeedequalsValue_shouldFilterRecords() {
        System.debug(Type.forName('List<Account>'));
        List<Account> testList = new List<Account>();
        testList.add(new Account(Name = 'Test123', AccountSource = 'Test'));
        testList.add(new Account(Name = 'Test1234', AccountSource = 'Test123'));
        testList.add(new Account(Name = 'Test1235', AccountSource = 'Test1235'));

        for(Integer i = 20; i< 600;i++){
            testList.add(new Account(Name = 'Test1235'+i, AccountSource = 'Test1235'));
        }
        List<Account> filtered = new List<Account>();
        Long systemCurrentTimeMillis = System.currentTimeMillis();
        for (Account acc : testList) {
            if(acc.Name == 'Test123'
                    && acc.AccountSource == 'Test'
                    && acc.AccountSource == 'Test'
                    && acc.AccountSource == 'Test'
                    ){
                filtered.add(acc);
            }
        }
        System.debug('Time: ' + (System.currentTimeMillis() - systemCurrentTimeMillis));

        System.assertEquals(1, filtered.size());
        System.assertEquals('Test123', filtered.get(0).Name);
    }

}