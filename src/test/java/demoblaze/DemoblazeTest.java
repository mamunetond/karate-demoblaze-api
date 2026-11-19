package demoblaze;

import com.intuit.karate.junit5.Karate;

class DemoblazeTest {

    @Karate.Test
    Karate testDemoblazeAuth() {
        return Karate.run("classpath:demoblaze/auth_demoblaze.feature");
    }
}