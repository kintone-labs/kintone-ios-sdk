# kintone-ios-sdk

> The SDK of kintone REST API client use for kintone-ios-sdk

## Create a project

- on cygwin

```bashshell
$ mvn -B archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=sample -DartifactId=sample
```

## Edit Pom.xml

- Pop.xml added Kintone-ios-sdk.jar dependency

```bashshell

$    <dependency>
$      <groupId>com.cybozu.kintone</groupId>
$      <artifactId>Kintone-ios-sdk</artifactId>
$      <version>1.0</version>
$    </dependency>
```

## Library download

- on cygwin

```bashshell
$ mvn dependency:copy-dependencies -DoutputDirectory=lib
$ cd lib
```

## References

- [kintone-ios-sdk](https://github.dev.cybozu.co.jp/pages/SC/kintone-ios-sdk/)


## License


MIT

## Copyright

Copyright(c) Cybozu, Inc.
