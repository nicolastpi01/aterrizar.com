package ar.edu.unq.epers.model
import org.junit.Before
import static org.mockito.Mockito.*
import org.junit.Test
import org.junit.Assert

/**
 * Created by damian on 4/2/16.
 */
class DummyTest {
    private int dummyValue

    @Before
    def void setUp(){
        dummyValue = 42
    }

    @Test
    def void mustBe42(){
        Assert.assertEquals(42,dummyValue)
    }

}