(in-package :mu-cl-resources)

(define-resource form-node ()
  :class (s-prefix "ext:FormNode")
  :properties `((:input-type-map :string ,(s-prefix "ext:typeMap")))
  :has-many `((form-input :via ,(s-prefix "ext:formInput")
                          :as "children")
              (dynamic-subform :via ,(s-prefix "ext:hasFormNode")
                               :inverse t
                               :as "parents"))
  :resource-base (s-url "http://data.lblod.info/form-nodes/")
  :on-path "form-nodes")

(define-resource form-input ()
  :class (s-prefix "ext:FormInput")
  :properties `((:index :number ,(s-prefix "ext:index"))
                (:display-type :string ,(s-prefix "ext:displayType"))
                (:label :string ,(s-prefix "dct:title"))
                (:options :string ,(s-prefix "ext:string"))
                (:identifier :string ,(s-prefix "adms:identifier")))
  :has-many `((dynamic-subform :via ,(s-prefix "ext:dynamicSubforms")
                               :as "dynamic-subforms"))
  :resource-base (s-url "http://data.lblod.info/form-inputs/")
  :on-path "form-inputs")

(define-resource dynamic-subform ()
  :class (s-prefix "ext:DynamicSubform")
  :properties `((:key :string ,(s-prefix "ext:key"))
                ;; match-kind is defined for resource properties.
                ;; Should be "uri" to match on object's uri property,
                ;; or "uuid" to match on its identifier.
                (:match-kind :string ,(s-prefix "ext:matchKind"))
                (:value :string ,(s-prefix "ext:value")))
  :has-one `((form-node :via ,(s-prefix "ext:hasFormNode")
                        :as "form-node"))
  :resource-base (s-url "http://data.lblod.info/dynamic-subforms/")
  :on-path "dynamic-subforms")

(define-resource form-solution ()
  :class (s-prefix "ext:FormSolution")
  :properties `((:has-owner :string ,(s-prefix "ext:hasOwnerAsString")))
  :has-one `((form-node :via ,(s-prefix "ext:hasForm")
                        :as "form-node")
             (company :via ,(s-prefix "ext:hasCompany")
                      :as "company"))
  :resource-base (s-url "http://data.lblod.info/solutions/")
  :on-path "form-solutions")


;;; bogus model for testing purpose

(define-resource company ()
  :class (s-prefix "ext:Company")
  :properties `((:name :string ,(s-prefix "dct:title")))
  :has-one `((person :via ,(s-prefix "ext:owner")
                     :as "owner"))
  :resource-base (s-url "http://data.lblod.info/companies/")
  :on-path "companies")

(define-resource person ()
  :class (s-prefix "foaf:Person")
  :properties `((:name :string ,(s-prefix "foaf:name")))
  :resource-base (s-url "http://data.lblod.info/people/")
  :on-path "people")
