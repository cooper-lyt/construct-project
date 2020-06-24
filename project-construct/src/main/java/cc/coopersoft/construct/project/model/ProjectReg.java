package cc.coopersoft.construct.project.model;

import cc.coopersoft.common.data.BusinessType;
import cc.coopersoft.common.data.RegSource;
import cc.coopersoft.common.data.RegStatus;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "PROJECT_REG")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Data
@NoArgsConstructor
//@NamedEntityGraph(name = "reg.summary",
//        attributeNodes = {@NamedAttributeNode("info")})
public class ProjectReg implements java.io.Serializable{


    public interface Title {}
    public interface Summary extends Title, ProjectRegInfo.Summary, JoinCorpReg.Summary,BuildReg.Summary {}
    public interface Details extends Title, ProjectRegInfo.Details, BuildReg.Details, JoinCorpReg.Details {}


    @Id
    @Column(name = "ID", unique = true, nullable = false)
    @JsonView(Title.class)
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CREATE_TIME", nullable = false)
    @JsonIgnore
    private Date createTime;

    @Column(name = "STATUS", nullable = false, length = 8)
    @Enumerated(EnumType.STRING)
    @JsonView(Title.class)
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private RegStatus status;

    @Basic(fetch = FetchType.LAZY)
    @Column(name = "TAGS", length = 512)
    @JsonIgnore
    private String tags;

    @Column(name = "PROJECT_CODE", nullable = false)
    @JsonView(Title.class)
    private long code;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "APPLY_TIME")
    @JsonView(Title.class)
    private Date applyTime;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "REG_TIME")
    @JsonView(Title.class)
    private Date regTime;

    @Column(name = "SOURCE", nullable = false, length = 8)
    @Enumerated(EnumType.STRING)
    @JsonView(Title.class)
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private RegSource source;

    @Column(name = "TYPE", length = 7, nullable = false)
    @Enumerated(EnumType.STRING)
    @JsonView(Title.class)
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private BusinessType type;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST , CascadeType.MERGE}, optional = false)
    @JoinColumn(name = "CORP", nullable = false)
    @JsonView(Title.class)
    private JoinCorpReg corp;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST , CascadeType.MERGE}, optional = false)
    @JoinColumn(name = "INFO", nullable = false)
    @JsonView(Title.class)
    private ProjectRegInfo info;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST , CascadeType.MERGE}, optional = false)
    @JoinColumn(name = "BUILD", nullable = false)
    @JsonView(Details.class)
    private BuildReg build;

    @Column(name = "CORP_MASTER",nullable = false)
    @JsonView(Details.class)
    private boolean corpMaster;

    @Column(name = "INFO_MASTER", nullable = false)
    @JsonView(Details.class)
    private boolean infoMaster;

    @Column(name = "BUILD_MASTER", nullable = false)
    @JsonView(Details.class)
    private boolean buildMaster;


}
