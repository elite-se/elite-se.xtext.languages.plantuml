/*
 * generated by Xtext 2.16.0
 */
package xyz.elite.xtext.languages.plantuml.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Test
import org.junit.Assert
import org.junit.runner.RunWith
import xyz.elite.xtext.languages.plantuml.plantUML.Model
import java.nio.file.Paths
import java.nio.file.Files
import java.nio.charset.StandardCharsets

@RunWith(XtextRunner)
@InjectWith(PlantUMLInjectorProvider)
class PlantUMLParsingTest {
	@Inject
	ParseHelper<Model> parseHelper

	def String loadPUML(String name) {
	    val uri = this.getClass().getResource("/" + name + ".puml")
        return String.join("\n", Files.readAllLines(Paths.get(uri.toURI()), StandardCharsets.UTF_8))
	}

	@Test
    def void empty() {
        val result = parseHelper.parse(loadPUML("empty"))
        if (result !== null) {
            val errors = result.eResource.errors
            Assert.assertFalse('''An empty PUML file should cause errors!''', errors.isEmpty);
        }
    }

    @Test
    def void minimal() {
        val result = parseHelper.parse(loadPUML("minimal"))
        Assert.assertNotNull(result)
    }

    @Test
    def void minimalFailing() {
        val result = parseHelper.parse(loadPUML("failing"))
        Assert.assertNotNull(result)
		val errors = result.eResource.errors
		print(errors)
        Assert.assertFalse('''Errors: «errors.join(", ")»''', errors.isEmpty);
    }

    @Test
    def void garbageLineShouldFail() {
        val result = parseHelper.parse(loadPUML("garbage-line"))
        Assert.assertNotNull(result)
		val errors = result.eResource.errors
        Assert.assertFalse('''Errors: «errors.join(", ")»''', errors.isEmpty);
    }

    @Test
    def void arrows() {
        val result = parseHelper.parse(loadPUML("arrows"))
        Assert.assertNotNull(result)
        val errors = result.eResource.errors
        Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
    }

    @Test
    def void colorfulArrows() {
        val result = parseHelper.parse(loadPUML("colorful-arrows"))
        Assert.assertNotNull(result)
        val errors = result.eResource.errors
        Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
    }

    @Test
    def void autonumber() {
        val result = parseHelper.parse(loadPUML("autonumber"))
        Assert.assertNotNull(result)
        val errors = result.eResource.errors
        Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
    }

    @Test
    def void pageMetaInfo() {
        val result = parseHelper.parse(loadPUML("page-meta-info"))
        Assert.assertNotNull(result)
        val errors = result.eResource.errors
        Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
    }

    @Test
    def void arbitraryDescription() {
        val result = parseHelper.parse(loadPUML("arbitrary-description"))
        Assert.assertNotNull(result)
        val errors = result.eResource.errors
        Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
    }    

	@Test
	def void allFeatures() {
		val result = parseHelper.parse(loadPUML("all-features"))
		Assert.assertNotNull(result)
		val errors = result.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
	}
}
