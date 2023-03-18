# Notes and Descriptions for the Presentation

<ul><li><a href='#Slide-1-The-Woods-for-the-Trees'>Slide 1: The Woods for the Trees</a>
</li><li><a href='#Slide-2-Definitions'>Slide 2: Definitions</a>
</li><li><a href='#Slide-3-and-4-Why-Visualise-and-How-about-now'>Slide 3 and 4: Why Visualise and How about now?</a>
</li><li><a href='#Slides-5-and-6-Climate-Strips'>Slides 5 and 6: Climate Strips</a>
</li><li><a href='#Slide-7-Data-Formats'>Slide 7: Data Formats</a>
</li><li><a href='#Slide-9-and-10-Copernicus-and-Seagrass'>Slide 9 and 10: Copernicus and Seagrass</a>
</li><li><a href='#Slide-11-Demo'>Slide 11: Demo</a>
</li><li><a href='#Slide-12-Accessibility'>Slide 12: Accessibility</a>
</li></ul>

### Slide 1: The Woods for the Trees

#### Description

The opening slide contains a photo by [K. Mitch Hodge](https://unsplash.com/@kmitchhodge?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) from [Unsplash](https://unsplash.com/photos/2202brFZ6pI?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) as the background. It is Tullymore Forest Park in Northern Ireland. It shows a stream with many trees in a variety of shades of green. The title is "The Wood for the Trees" which is overlayed on top with the subtitle "Visualising Environmental Data" by Patrick Ferris.

#### Dicussion

I'm [Patrick Ferris](https://patrick.sirref.org), a Research Assistant with the Energy and Environment Group at the Department of Computer Science and Technology.

This presentation is all about visualisations and how they can be used with environmental data. There will be a strong focus on higher-level questions like what it means to visualise something, why bother etc.? Later we will then create some simple visualisations in the browser. The goal is not to become experts in some library `X` for doing visualisations. There's simply not enough time in a 60 minute presentation.

### Slide 2: Definitions

#### Description

Two definitions are shown on screen:

> You gotta see it in your mind. Can you picture that?
>
>   Dr Teeth and the Electric Mayhem

> The act or an example of creating an image, etc. to represent something
>
>   Cambridge Dictionary

#### Discussion

What exactly is a visualisation? In English, we usually mean two quite related things. Either, the act of imagining something in your mind like thinking of the answer to "Where do you see yourself in 5 years?" or creating a representation of something else.

### Slide 3 and 4: Why Visualise and How about now?

#### Description

This slide has no images only text. There is some CSV text showing rows of data for points on a map. Each row has a name, a longitude and a latitude.

The second slide shows the same points only plotted on to a map of Belfast. This makes it much easier to find the two points that are the closest.

#### Discussion

This is a jumping off point for considering what are we trying to do when we visualise environmental data (or any data for that matter). What are the trade-offs, what is the agenda, what have we lost along the way?

Here we have a few important points to make:

 - Raw data does not necessarily fit well with many people's ability to make inferences or recognise patterns, certainly not in a textual format.
 - Instead, many people are good at recognising spatial patterns and relationships. If we want to make the point that two points (i.e. a longitude and latitude pair) are close together then representing them spatially on a map is a good idea.
 - The raw data is now also contextualised: their points in and around Belfast city.
 - However, on the map we've decided to remove the point labels along with the exact floating point number for the longitude and latitude. This means we can no longer answer precisely the two points that are closest together nor can we tell how close they actually are.

### Slides 5 and 6: Climate Strips

#### Description

These two slides show the same image but the first has been altered to appear as it might for people with [protanopia](https://www.nhs.uk/conditions/colour-vision-deficiency/), a colour-vision deficiency that results from an insensitivity to red light. The image is quite famous, called [climate stripes](https://showyourstripes.info/s/globe).

#### Discussion

Accessibility and context matters. A quick caveat that a lot of the points I'm about to raise are [actually pretty well-handled by the University of Reading's online visualisation](https://showyourstripes.info/s/globe) as we shall see.

The climate stripes show the relative difference between the average global temperature and the average between 1971-2000. From left to right, we span the years 1850-2021 with a low of around -0.6 degrees celsius to +0.6.

The first image tries to show how the climate stripes without any other context to someone with protanopia are hard to read and make any good inference from.

The second image, is the normal climate stripes that have been used on the cover of [Greta Thunberg's The Climate Book](https://www.penguin.co.uk/books/446610/the-climate-book-by-thunberg-greta/9780241547472) -- and the point this, presented like this they aren't much better. We don't know the time period, the scale, what the baseline is etc.

Finally, the third image solves lots of these problems but would probably not look great on the front cover of a book.

### Slide 7: Data Formats

#### Description

A boring slide with bullet points for a few data formats which are explained in the next discussion section.

#### Discussion

Environmental data comes in all sorts of weird and wonderful data formats. We can't get into all of them, or all of the details but we'll take a quick tour of the most popular ones.

##### Images: `png`, `jpeg` and `tif`

##### JSON: GeoJSON and TopoJSON

[JSON](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON) is a format for representing structured data, it is often easiest to think about it a bit like a dictionary i.e. key-value pairs.

[GeoJSON](https://www.rfc-editor.org/rfc/rfc7946) is a standardised (by the IETF) format built on top of JSON. It is essentially a schema for representing geospatial data in JSON. Here's an example:

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {"type": "Point", "coordinates": [102.0, 0.5]},
      "properties": {"name": "A"}
    },
  ]
}
```

[TopoJSON](https://github.com/topojson/topojson-specification) optimises GeoJSON by utilising the topological information of the geospatial primitives to store less data. Concretely, if you have two polygons that share a boundary (e.g. the border between Scotland and England) then in TopoJSON this will only be stored once whereas in GeoJSON the points will be stored twice.

##### XML: `kml`

`XML` (extensible markup language) is format for storing arbitrary data. `KML` is the *Keyhole Markup Language* which adds some geospatial specific features such as place marks and polygons. Google Earth uses KML, here's an example:

```kml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
<Placemark>
  <name>Belfast City</name>
  <description>Belfast City</description>
  <Point>
    <coordinates>-76.3833333,17.8833333,0.</coordinates>
  </Point>
</Placemark>
</Document>
</kml>
```

`GML` is another variant that also is very useful for incorporating things like sensor data given it has primitives for *time*, *unit of measurement* etc.

##### Shapefiles

Shapefiles are quite tightly coupled with GIS software tools, and instead of diving into that feel free [to have a look at the Wikipedia page](https://en.wikipedia.org/wiki/Shapefile). The high-level comment is that they store vector GIS data.

### Slide 9 and 10: Copernicus and Seagrass

#### Description

The first slide shows data from Copernicus:

> Copernicus is the Earth observation component of the European Union’s Space programme, looking at our planet and its environment to benefit all European citizens. It offers information services that draw from satellite Earth Observation and in-situ (non-space) data.

The second slide is a screenshot of the [NI Forests App](https://patricoferris.github.io/ni-forests/) for the seagrass section. It shows seagrass polygons in Strangford Lough coupling high-resolution satellite images with structured data.

#### Discussion

The Copernicus image shows the [Fraction of Absorbed Photosynthetically Active Radation (FAPAR)](https://land.copernicus.eu/global/products/fapar). The PAR part is the solar raditation in the spectral ranger that is used by vegetation to produce organic material. We are then interested in the part of the PAR that reaches Earth that is usefully absorbed by plants. We can then infer things like canopy productivity from it for example.

The seagrass data is a mixture of [opendatani](https://www.opendatani.gov.uk/@department-of-agriculture-environment-and-rural-affairs/subtidal-and-intertidal-seagrass-beds3) and information from the [Seagrass Project](https://www.projectseagrass.org) who are doing very cool [citizen science](https://seagrassspotter.org). The [seagrass restoration handbook](https://catchmentbasedapproach.org/learn/seagrass-restoration-handbook/) is an accessible and interesting read on the subject in the UK.


### Slide 11: Demo

A demo was then given including:

 - [Some simple trees plotted on a map](http://patricoferris.github.io/the-woods-for-the-trees/visualise)
 - [NI Forests](https://patricoferris.github.io/ni-forests/)
 - [4C Quantify Earth](https://staging.quantify.earth/#/gola)
 - [4C Globe](https://staging.quantify.earth/#/globe)

### Slide 12: Accessibility

Through out the presentation, matters of accessibility were referenced to and in part these notes try to improve a little on that situation as well. However, it would take at least another presentation to talk about matters of accessibility in data visualtion.

I thought I would point to one interesting research paper called [Understanding and Improving Information Extraction From Online Geospatial Data Visualizations for Screen-Reader Users](https://athersharif.me/documents/assets-2022-voxlens-geospatial.pdf) in which the [VoxLens](https://www.youtube.com/watch?v=_ACIJafIRuU) (an open-source multi-modal solution that improves data visualization accessibility) tools in extended to include geospatial queries.

In one of the [original papers](https://dl.acm.org/doi/10.1145/3441852.3471202) they found

> Our results show that due to the inaccessibility of online data visualizations, screen-reader users extract information 61.48% less accurately and spend 210.96% more time interacting with online data visualizations compared to non-screen-reader users

Clearly there is a lot of room for improvement and research in this area.

Thanks for reading!